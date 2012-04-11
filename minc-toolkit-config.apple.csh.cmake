# minc-toolkit configuration parameters for @MINC_TOOLKIT_VERSION_FULL@

setenv MINC_TOOLKIT_VERSION "@MINC_TOOLKIT_VERSION_FULL@"
setenv PATH @CMAKE_INSTALL_PREFIX@/bin:${PATH}

if ( ! ${?PERL5LIB} ) then
setenv PERL5LIB @CMAKE_INSTALL_PREFIX@/perl
else
setenv PERL5LIB @CMAKE_INSTALL_PREFIX@/perl:${PERL5LIB}
endif

if ( ! ${?DYLD_LIBRARY_PATH} ) then
setenv DYLD_LIBRARY_PATH @CMAKE_INSTALL_PREFIX@/lib
else
setenv DYLD_LIBRARY_PATH ${DYLD_LIBRARY_PATH}:@CMAKE_INSTALL_PREFIX@/lib
endif


if ( ! ${?MNI_DATAPATH} ) then  
  setenv MNI_DATAPATH @CMAKE_INSTALL_PREFIX@/share
else
  setenv MNI_DATAPATH @CMAKE_INSTALL_PREFIX@/share:${MNI_DATAPATH}
endif


setenv MINC_FORCE_V2 1
setenv MINC_COMPRESS 4
setenv VOLUME_CACHE_THRESHOLD -1
