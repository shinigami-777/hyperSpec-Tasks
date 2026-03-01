use extendr_api::prelude::*;
use faer::Mat;

#[extendr]
fn row_sums_rust(matrix: Robj) -> Vec<f64> {
    let nrows = matrix.nrows();
    let ncols = matrix.ncols();
    
    let mut data = Vec::with_capacity(nrows * ncols);
    
    // Try double matrix first, fall back to integer
    if let Ok(rmatrix) = RMatrix::<f64>::try_from(matrix.clone()) {
        // It's already a double matrix
        for col in 0..ncols {
            for row in 0..nrows {
                data.push(rmatrix[[row, col]]);
            }
        }
    } else if let Ok(rmatrix) = RMatrix::<i32>::try_from(matrix.clone()) {
        // It's an integer matrix, convert to f64
        for col in 0..ncols {
            for row in 0..nrows {
                data.push(rmatrix[[row, col]] as f64);
            }
        }
    } else {
        panic!("Input must be a numeric matrix (integer or double)");
    }
    
    let faer_mat = Mat::from_fn(nrows, ncols, |i, j| data[j * nrows + i]);
    let mut row_sums = vec![0.0; nrows];
    for i in 0..nrows {
        let mut sum = 0.0;
        for j in 0..ncols {
            sum += faer_mat.read(i, j);
        }
        row_sums[i] = sum;
    }
    
    row_sums
}

extendr_module! {
    mod matrixrowsum;
    fn row_sums_rust;
}