/*
 *  types.h
 *  MemoryIt
 *
 *  Created by duangan on 12-4-26.
 *  Copyright 2012 __MyCompanyName__. All rights reserved.
 *
 */

// base feature macro.
#define MI_DEBUG
#define MI_UT
#define MI_ST

/* base type define. */
#define int64		long long
#define int32		int
#define	uint32		unsigned int
#define int8		char
#define uint8		unsigned char

// the way type to transfer card to thread.
typedef enum {
    NORMAL_WAY,
    BIG_CYCLE_WAY,
    SMALL_CYCLE_WAY,
    USER_DEFINE_WAY,
    MAX_WAY
} way_type;

// the type of step to show.
typedef enum {
    MEMORY_STEP,
    REVIEW_STEP,
    MAX_STEP
} step_type;

// max log file size, is 3MB.
#define MAX_LOG_FILE_SIZE (3 * 1024 * 1024)

// max ribbon count define.
#define MAX_RIBBON_COUNT  100

// card count define, default and max.
#define DEFAULT_CARD_COUNT 100
#define MAX_CARD_COUNT 150

// thread count define, default and max.
#define DEFAULT_THREAD_COUNT 1000
#define MAX_THREAD_COUNT 1500

// define ready ribbon standard
#define RIBBON_READY_STANDARD   80

// define champion count
#define CHAMPION_COUNT_MAX    20

// define first view to show.
typedef enum {
    THREAD_SHOW_FIRST_VIEW,
    RIBBON_LIST_FIRST_VIEW,
    RIBBON_DETAIL_SHOW,
    MAX_FIRST_SHOW
} first_view_type;

// define thread show mode
typedef enum{
    NORMAL_MODE,
    REVIEW_MODE,
    TEST_MODE,
    MODIFY_MODE,
    MAX_MODE
}thread_show_mode;

// define sqlite file name
#define MEMORYIT_DATABASE_NAME @"memoryit.sqlite3"

// define database handler error type
typedef enum{
    DB_EXEC_OK,
    DB_FILE_CREATE_FAIL,
    DB_OPEN_FAIL,
    DB_CREATE_TABLE_FAIL,
    DB_OPEN_TABLE_FAIL,
    DB_TABLE_HAS_DUMP_DATA,
    DB_EXEC_FAIL,     // 不常见命令的执行错误。
    DB_SELECT_FAIL,   // SELECT
    DB_INSERT_FAIL,   // INSERT
    DB_UPDATE_FAIL,   // UPDATE
    DB_DELETE_FAIL,   // DELETE
    DB_OTHER_FAIL,    // 非数据库的错误，比如数据没有准备好等。
    DB_MAX
}db_handler_error;

// define statistics data update flag.
typedef enum{
    STATISTICS_DATA_UPDATED,    // 数据已刷新
    STATISTICS_DATA_DIRTY       // 数据待刷新。
}statistics_data_flag;
