! icbp : iso_c_binding for parpack

subroutine pdnaupd_c(comm, ido, bmat, n, which, nev, tol, resid, ncv, v, ldv,&
                     iparam, ipntr, workd, workl, lworkl, info)              &
                     bind(c, name="pdnaupd_c")
  use :: iso_c_binding
#ifdef HAVE_MPI_ICB
  use :: mpi_f08
#endif
  implicit none
#include "arpackicb.h"
#ifdef HAVE_MPI_ICB
  type(MPI_Comm),         value,               intent(in)    :: comm
#else
  integer(kind=i_int),    value,               intent(in)    :: comm
#endif
  integer(kind=i_int),                         intent(inout) :: ido
  character(kind=c_char),                      intent(in)    :: bmat
  integer(kind=i_int),    value,               intent(in)    :: n
  character(kind=c_char), dimension(2),        intent(in)    :: which
  integer(kind=i_int),    value,               intent(in)    :: nev
  real(kind=c_double),    value,               intent(in)    :: tol
  real(kind=c_double),    dimension(n),        intent(inout) :: resid
  integer(kind=i_int),    value,               intent(in)    :: ncv
  real(kind=c_double),    dimension(ldv, ncv), intent(out)   :: v
  integer(kind=i_int),    value,               intent(in)    :: ldv
  integer(kind=i_int),    dimension(11),       intent(inout) :: iparam
  integer(kind=i_int),    dimension(14),       intent(out)   :: ipntr
  real(kind=c_double),    dimension(3*n),      intent(out)   :: workd
  real(kind=c_double),    dimension(lworkl),   intent(out)   :: workl
  integer(kind=i_int),    value,               intent(in)    :: lworkl
  integer(kind=i_int),                         intent(inout) :: info
  
  character(len=2):: w
  integer         :: i
  
  do i =1,2
      w(i:i) = which(i)
  end do
  
  call pdnaupd(comm, ido, bmat, n, w, nev, tol, resid, ncv, v, ldv,&
               iparam, ipntr, workd, workl, lworkl, info)
end subroutine pdnaupd_c

subroutine pdneupd_c(comm, rvec, howmny, select,                  &
                     dr, di, z, ldz, sigmar, sigmai, workev,      &
                     bmat, n, which, nev, tol, resid, ncv, v, ldv,&
                     iparam, ipntr, workd, workl, lworkl, info)   &
                     bind(c, name="pdneupd_c")
  use :: iso_c_binding
#ifdef HAVE_MPI_ICB
  use :: mpi_f08
#endif
  implicit none
#include "arpackicb.h"
#ifdef HAVE_MPI_ICB
  type(MPI_Comm),         value,               intent(in)    :: comm
#else
  integer(kind=i_int),    value,               intent(in)    :: comm
#endif
  integer(kind=i_int),    value,               intent(in)    :: rvec
  character(kind=c_char),                      intent(in)    :: howmny
  integer(kind=i_int),    dimension(ncv),      intent(in)    :: select
  real(kind=c_double),    dimension(nev+1),    intent(out)   :: dr
  real(kind=c_double),    dimension(nev+1),    intent(out)   :: di
  real(kind=c_double),    dimension(n, nev+1), intent(out)   :: z
  integer(kind=i_int),    value,               intent(in)    :: ldz
  real(kind=c_double),    value,               intent(in)    :: sigmar
  real(kind=c_double),    value,               intent(in)    :: sigmai
  real(kind=c_double),    dimension(3*ncv),    intent(out)   :: workev
  character(kind=c_char),                      intent(in)    :: bmat
  integer(kind=i_int),    value,               intent(in)    :: n
  character(kind=c_char), dimension(2),        intent(in)    :: which
  integer(kind=i_int),    value,               intent(in)    :: nev
  real(kind=c_double),    value,               intent(in)    :: tol
  real(kind=c_double),    dimension(n),        intent(inout) :: resid
  integer(kind=i_int),    value,               intent(in)    :: ncv
  real(kind=c_double),    dimension(ldv, ncv), intent(out)   :: v
  integer(kind=i_int),    value,               intent(in)    :: ldv
  integer(kind=i_int),    dimension(11),       intent(inout) :: iparam
  integer(kind=i_int),    dimension(14),       intent(out)   :: ipntr
  real(kind=c_double),    dimension(3*n),      intent(out)   :: workd
  real(kind=c_double),    dimension(lworkl),   intent(out)   :: workl
  integer(kind=i_int),    value,               intent(in)    :: lworkl
  integer(kind=i_int),                         intent(inout) :: info

  ! convert parameters if needed.

  logical :: rv
  logical, dimension(ncv) :: slt
  integer :: idx
  character(len=2):: w
  integer         :: i
  
  rv = .false.
  if (rvec .ne. 0) rv = .true.

  slt = .false.
  do idx=1, ncv
    if (select(idx) .ne. 0) slt(idx) = .true.
  enddo

  do i =1,2
      w(i:i) = which(i)
  end do

  ! call arpack.

  call pdneupd(comm, rv, howmny, slt,                       &
               dr, di, z, ldz, sigmar, sigmai, workev,      &
               bmat, n, w, nev, tol, resid, ncv, v, ldv,&
               iparam, ipntr, workd, workl, lworkl, info)
end subroutine pdneupd_c
