{ stdenv, gfortran, hdf5-full, hdf5-fortran }:

stdenv.mkDerivation {
  pname = "hdf5-fortran-test";
  version = "1.0";

  src = ./.;

  nativeBuildInputs = [ gfortran ];
  buildInputs = [ hdf5-fortran ];

  # preBuild = ''
  #   export NIX_LD_LIBRARY_PATH=${hdf5-full}/lib:${hdf5-full}/include:$NIX_LD_LIBRARY_PATH
  # '';

  NIX_LDFLAGS = "-lhdf5 -L${hdf5-fortran.dev}/include";
  NIX_DEBUG = 1;
  buildPhase = ''
    gfortran -I${hdf5-fortran}/lib -I${hdf5-fortran.dev}/include -lhdf5 -o main main.f90 
  '';
  FFLAGS = [ "-std=legacy" "-fPIC" ];
  FCFLAGS = [ "-std=legacy" "-fPIC" ];

  installPhase = ''
    install -D main $out/bin/main
  '';
}
