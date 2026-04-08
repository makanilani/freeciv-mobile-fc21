/**
 * @file determinism_test.h
 * @brief Determinism test declarations
 */

#ifndef DETERMINISM_TEST_H
#define DETERMINISM_TEST_H

#ifdef __cplusplus
extern "C" {
#endif

/**
 * Run all determinism tests
 * @return 0 if all tests pass, non-zero on failure
 */
int run_determinism_tests(void);

#ifdef __cplusplus
}
#endif

#endif // DETERMINISM_TEST_H