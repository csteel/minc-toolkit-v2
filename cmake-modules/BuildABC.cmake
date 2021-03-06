macro(build_ABC install_prefix staging_prefix)
  if(CMAKE_EXTRA_GENERATOR)
    set(CMAKE_GEN "${CMAKE_EXTRA_GENERATOR} - ${CMAKE_GENERATOR}")
  else()
    set(CMAKE_GEN "${CMAKE_GENERATOR}")
  endif()
  
  set(CMAKE_OSX_EXTERNAL_PROJECT_ARGS)
  if(APPLE)
    SET(ITK_CXX_COMPILER "${CMAKE_CXX_COMPILER}" CACHE FILEPATH "C++ Compiler for ITK")
    SET(ITK_C_COMPILER "${CMAKE_C_COMPILER}" CACHE FILEPATH "C Compiler for ITK")
    list(APPEND CMAKE_OSX_EXTERNAL_PROJECT_ARGS
      -DCMAKE_OSX_ARCHITECTURES=${CMAKE_OSX_ARCHITECTURES}
      -DCMAKE_OSX_SYSROOT=${CMAKE_OSX_SYSROOT}
      -DCMAKE_OSX_DEPLOYMENT_TARGET=${CMAKE_OSX_DEPLOYMENT_TARGET}
      -DCMAKE_C_COMPILER:FILEPATH=${ITK_C_COMPILER}
      -DCMAKE_CXX_COMPILER:FILEPATH=${ITK_CXX_COMPILER}
    )
  endif()

  ExternalProject_Add(ABC
    GIT_REPOSITORY "https://github.com/vfonov/abc.git"
    GIT_TAG "53f7b49fce0d2226667f323cffb1f59cee30c2ee"
    UPDATE_COMMAND ""
    SOURCE_DIR ABC
    BINARY_DIR ABC-build
    LIST_SEPARATOR :::  
    CMAKE_GENERATOR ${CMAKE_GEN}
    CMAKE_ARGS
        -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
        -DITK_DIR:PATH=${ITK_DIR}
        -DCMAKE_INSTALL_PREFIX:PATH=${install_prefix}
        -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS}
        -DCMAKE_C_FLAGS:STRING=${CMAKE_C_FLAGS}
        -DCMAKE_EXE_LINKER_FLAGS=${CMAKE_EXE_LINKER_FLAGS}
        -DCMAKE_MODULE_LINKER_FLAGS=${CMAKE_MODULE_LINKER_FLAGS}
        -DCMAKE_SHARED_LINKER_FLAGS=${CMAKE_SHARED_LINKER_FLAGS}
        -DCOMPILE_COMMANDLINE:BOOL=ON
        -DCOMPILE_SLICER4COMMANDLINE:BOOL=OFF
        -DCOMPILE_STANDALONEGUI:BOOL=OFF
        -DCMAKE_SKIP_RPATH:BOOL=OFF
        -DCMAKE_SKIP_INSTALL_RPATH:BOOL=OFF
        -DMACOSX_RPATH:BOOL=ON
        -DCMAKE_INSTALL_RPATH:PATH=${install_prefix}/lib${LIB_SUFFIX}
        ${CMAKE_OSX_EXTERNAL_PROJECT_ARGS}
    INSTALL_COMMAND $(MAKE) install DESTDIR=${staging_prefix}
    INSTALL_DIR ${staging_prefix}/${install_prefix}
  )
endmacro(build_ABC)
