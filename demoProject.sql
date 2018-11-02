

/*.........   NEW ms_student   ................*/

CREATE TABLE  ms_student (
  email     varchar(50)  NOT NULL  PRIMARY KEY,
  Name      varchar(50)  NOT NULL,
  address   varchar(250) NOT NULL,
  phone     bigint       NOT NULL,
  dob       date         NOT NULL, 
  password  char(128)    NOT NULL,
  salt      char(128)    NOT NULL,
  roles     varchar(20)  DEFAULT 'student',
  status    int          DEFAULT 1,
  active    int          DEFAULT 0
  );
/*..............................................  admin    ..........*/
update ms_student
set roles='admin'
where email='admin@admin.com';/* password = Admin@123 */
/*....................    NEW  ms_question   ......... */
  CREATE TABLE   ms_question (
  questionId     int           NOT NULL IDENTITY (1, 1) PRIMARY KEY,
  question       varchar(900)  NOT NULL,
  option1        varchar(250)  NOT NULL,
  option2        varchar(250)  NOT NULL,
  option3        varchar(250)  NOT NULL,
  option4        varchar(250)  NOT NULL,
  answer         int           NOT NULL,
  subject        varchar(30)   NOT NULL,
  status         int           DEFAULT 1
  );
 /*....................    NEW   ms_result         .............. */
CREATE TABLE  ms_result (
  resultId       int           NOT NULL IDENTITY (1, 1) PRIMARY KEY,
  studentEmail   varchar(50)   NOT NULL,
  startDate      datetime      NOT NULL,
  endDate        datetime      DEFAULT NULL, 
  score          int           DEFAULT 0,
  totalquestion  int           NOT NULL,
  subject        varchar(30)   NOT NULL,
  status         int           DEFAULT 1,
  testId         int     FOREIGN KEY REFERENCES ms_test(testId)
  ); 
/*.......................  NEW   ms_password   ........*/
  CREATE TABLE   ms_password (
  pid       int          NOT NULL IDENTITY (1, 1) PRIMARY KEY,
  email     varchar(50)  NOT NULL ,
  guids     char(36)     NOT  NULL,
  times     datetime     NOT NULL
  
  );
 /*....................... NEW ms_test ..............*/
 CREATE TABLE   ms_test (
  testId          int        NOT NULL IDENTITY (1, 1) PRIMARY KEY,
  test          varchar(15)  NOT NULL,
  startTime     datetime     NOT NULL,
  duration      int          NOT NULL,
  totalQuestion int          NOT NULL
  )

INSERT INTO ms_test (test, startTime, duration,totalQuestion)
VALUES ('English','2018-10-01 06:59:00',20,6);
  /*...............................................*/




