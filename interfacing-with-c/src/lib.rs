use std::ffi::c_int;

#[link(name = "adder", kind = "static")]
extern "C" {
    fn add(x: c_int, y: c_int) -> c_int;
}

pub fn wrapped_add(x: i32, y: i32) -> i32 {
    unsafe { add(x.into(), y.into()) }
}

#[cfg(test)]
mod tests {
    #[test]
    fn wrapped_add_test() {
        assert_eq!(7, super::wrapped_add(4, 3));
    }
}
