# SLAM Dockerfile Setting

## Base Image
- **Ubuntu 20.04**

## Installed Libraries
The following libraries and tools are installed in this Docker environment:

- **OpenCV**: 4.8.1
- **Eigen**: 3.3.8
- **Sophus**: 1.22.10
- **Pangolin**: 0.6
- **Ceres-Solver**: 2.1.0
- **Miniconda**: Latest version for `x86_64`
- **G2O**: Master branch

---

## Common CMake Error: Case 1

### Error Description
When using `find_package(G2O REQUIRED)` in your CMake project, you may encounter the following error:

CMake Error at CMakeLists.txt:19 (find_package):
  By not providing "FindG2O.cmake" in CMAKE_MODULE_PATH this project has
  asked CMake to find a package configuration file provided by "G2O", but
  CMake did not find one.

  Could not find a package configuration file provided by "G2O" with any of
  the following names:

    G2OConfig.cmake
    g2o-config.cmake

  Add the installation prefix of "G2O" to CMAKE_PREFIX_PATH or set "G2O_DIR"
  to a directory containing one of the above files.  If "G2O" provides a
  separate development package or SDK, be sure it has been installed.

### How I solve the error
If you meet this error case for "find_package(G2O REQUIRED)", just make the symbolic link files like:

```bash
$ sudo ln -s /usr/local/lib/cmake/g2o/g2oConfig.cmake /usr/local/lib/cmake/g2o/G2OConfig.cmake
$ sudo ln -s /usr/local/lib/cmake/g2o/g2oConfig.cmake /usr/local/lib/cmake/g2o/g2o-config.cmake
```

