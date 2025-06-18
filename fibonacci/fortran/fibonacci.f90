module fibonacci_module
    implicit none
    private  ! Everything is private by default...
    public :: fibonacci  ! Except what we explicitly expose

contains

    recursive function fib_internal(n) result(f)
        integer(8), intent(in) :: n
        integer(8) :: f

        if (n == 0) then
            f = 0
        elseif (n == 1) then
            f = 1
        else
            f = fib_internal(n - 1) + fib_internal(n - 2)
        end if
    end function fib_internal

    function fibonacci(n) result(f)
        integer(8), intent(in) :: n
        integer(8) :: f

        f = fib_internal(n)
    end function fibonacci

end module fibonacci_module
