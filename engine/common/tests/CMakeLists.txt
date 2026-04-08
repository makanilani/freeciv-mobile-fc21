set(CMAKE_AUTOMOC ON)

# Determinism test for mobile
add_executable(test_determinism determinism_test.cpp)
target_link_libraries(test_determinism PRIVATE common Qt6::Test)
add_test(NAME determinism_test COMMAND test_determinism)

# Existing DIO test
add_executable(test_dio dio.cpp)
target_link_libraries(test_dio PRIVATE common Qt6::Test)
add_test(NAME test_dio COMMAND test_dio)
