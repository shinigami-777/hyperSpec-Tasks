use extendr_api::prelude::*;
use faer::sparse::{SymbolicSparseColMatRef, SparseColMatRef};

#[extendr]
fn sparse_degree(matrix: Robj) -> Robj {
    let s4 = S4::try_from(matrix).unwrap();

    // Extract dgCMatrix slots
    let i_slot: Vec<i32> = s4.get_slot("i").unwrap().try_into().unwrap();
    let p_slot: Vec<i32> = s4.get_slot("p").unwrap().try_into().unwrap();
    let x_slot: Vec<f64> = s4.get_slot("x").unwrap().try_into().unwrap();
    let dim: Vec<i32> = s4.get_slot("Dim").unwrap().try_into().unwrap();

    let nrows = dim[0] as usize;
    let ncols = dim[1] as usize;

    let row_indices: Vec<usize> =
        i_slot.iter().map(|&v| v as usize).collect();
    let col_ptrs: Vec<usize> =
        p_slot.iter().map(|&v| v as usize).collect();

    // SAFETY: dgCMatrix guarantees valid CSC structure
    let symbolic = unsafe {
        SymbolicSparseColMatRef::<usize>::new_unchecked(
            nrows,
            ncols,
            &col_ptrs,
            None,
            &row_indices,
        )
    };

    let values: &[f64] = x_slot.as_slice();

    let _mat: SparseColMatRef<usize, f64> =
        SparseColMatRef::new(symbolic, values);

    // Allocate R vector (WritableSlice)
    let mut output = Doubles::new(nrows);
    let degree = output.as_mut();

    // Compute row sums
    for col in 0..ncols {
        let start = col_ptrs[col];
        let end = col_ptrs[col + 1];

        for idx in start..end {
            let row = row_indices[idx];
            degree[row] += x_slot[idx];
        }
    }

    output.into()
}

extendr_module! {
    mod sparsematrixprocessing;
    fn sparse_degree;
}