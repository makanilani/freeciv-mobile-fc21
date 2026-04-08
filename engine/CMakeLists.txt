# Freeciv21 Engine Core - CMake Configuration
# This file includes all engine components while excluding the removed Qt6 client

cmake_minimum_required(VERSION 3.21...4.3 FATAL_ERROR)

project(freeciv21-engine VERSION 0.0.1 LANGUAGES C CXX)

# Include engine subdirectories
add_subdirectory(common)
add_subdirectory(utility)
add_subdirectory(server)
add_subdirectory(ai)
add_subdirectory(data)
add_subdirectory(lua)
add_subdirectory(tools)

# Exclude the removed Qt6 client (not needed for mobile)
# add_subdirectory(client)  # REMOVED - Qt6 client not used

# Include dependencies
add_subdirectory(dependencies)

# Include translations
add_subdirectory(translations)

# Optional: Add tests if needed
if(BUILD_TESTING)
    add_subdirectory(common/tests)
    add_subdirectory(utility/tests)
    add_subdirectory(data/tests)
    add_subdirectory(server/tests)
    add_subdirectory(tools/tests)
endif()