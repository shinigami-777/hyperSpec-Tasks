use extendr_api::prelude::*;
use faer::Mat;

#[extendr]
fn row_sums_rust(x: RMatrix<f64>) -> Vec<f64> {
    let nrows = x.nrows();
    let ncols = x.ncols();
    
    // R matrices are stored column-major, convert to faer Mat
    let mat = Mat::from_fn(nrows, ncols, |i, j| x[[i, j]]);
    
    let mut row_sums = Vec::with_capacity(nrows);
    
    for i in 0..nrows {
        let mut sum = 0.0;
        for j in 0..ncols {
            sum += mat.read(i, j);
        }
        row_sums.push(sum);
    }

    row_sums
}

extendr_module! {
    mod matrixrowsum;
    fn row_sums_rust;
}