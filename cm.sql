-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.0.41-community-nt


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema coaching_management
--

CREATE DATABASE IF NOT EXISTS coaching_management;
USE coaching_management;

--
-- Definition of table `admin_login`
--

DROP TABLE IF EXISTS `admin_login`;
CREATE TABLE `admin_login` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `ausername` varchar(45) NOT NULL,
  `apassword` varchar(45) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin_login`
--

/*!40000 ALTER TABLE `admin_login` DISABLE KEYS */;
INSERT INTO `admin_login` (`id`,`ausername`,`apassword`) VALUES 
 (1,'admin','123'),
 (2,'sayem','123');
/*!40000 ALTER TABLE `admin_login` ENABLE KEYS */;


--
-- Definition of table `exam`
--

DROP TABLE IF EXISTS `exam`;
CREATE TABLE `exam` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `e_name` varchar(45) NOT NULL,
  `e_time` varchar(45) NOT NULL,
  `sub_name` varchar(45) NOT NULL,
  `e_date` date NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `exam`
--

/*!40000 ALTER TABLE `exam` DISABLE KEYS */;
INSERT INTO `exam` (`id`,`e_name`,`e_time`,`sub_name`,`e_date`) VALUES 
 (1,'Model Test','12:00 PM','JAVA','2019-01-01'),
 (2,'Final Exam','11:00 PM','DataBase','2019-01-01'),
 (3,'First Semister','12:00 PM','Web Design','2019-02-05');
/*!40000 ALTER TABLE `exam` ENABLE KEYS */;


--
-- Definition of table `fund`
--

DROP TABLE IF EXISTS `fund`;
CREATE TABLE `fund` (
  `f_id` int(10) unsigned NOT NULL default '0',
  `description` varchar(45) NOT NULL,
  `income` double NOT NULL default '0',
  `expense` double NOT NULL default '0',
  PRIMARY KEY  (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `fund`
--

/*!40000 ALTER TABLE `fund` DISABLE KEYS */;
INSERT INTO `fund` (`f_id`,`description`,`income`,`expense`) VALUES 
 (1,'Student Payment Income',152000,0),
 (2,'Teacher Payment Expense',0,135000),
 (3,'Other Expense',0,1200);
/*!40000 ALTER TABLE `fund` ENABLE KEYS */;


--
-- Definition of table `get_payment`
--

DROP TABLE IF EXISTS `get_payment`;
CREATE TABLE `get_payment` (
  `p_id` int(10) unsigned NOT NULL auto_increment,
  `s_id` int(10) unsigned NOT NULL,
  `name` varchar(45) NOT NULL,
  `p_month` varchar(45) NOT NULL,
  `amount` double NOT NULL,
  `p_date` date NOT NULL,
  PRIMARY KEY  (`p_id`),
  KEY `FK_get_payment_sid` (`s_id`),
  CONSTRAINT `FK_get_payment_sid` FOREIGN KEY (`s_id`) REFERENCES `student` (`s_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `get_payment`
--

/*!40000 ALTER TABLE `get_payment` DISABLE KEYS */;
INSERT INTO `get_payment` (`p_id`,`s_id`,`name`,`p_month`,`amount`,`p_date`) VALUES 
 (8,1,'Sayem','January',50000,'2019-01-01'),
 (10,2,'Sajid','July',32000,'2019-01-06'),
 (12,2,'Sajid','June',35000,'2019-01-06'),
 (13,3,'Sayma','January',35000,'2019-01-01');
/*!40000 ALTER TABLE `get_payment` ENABLE KEYS */;


--
-- Definition of trigger `insertFundStudent`
--

DROP TRIGGER /*!50030 IF EXISTS */ `insertFundStudent`;

DELIMITER $$

CREATE DEFINER = `root`@`localhost` TRIGGER `insertFundStudent` BEFORE INSERT ON `get_payment` FOR EACH ROW BEGIN
update fund
set income = income + new.amount
where f_id = 1;
END $$

DELIMITER ;

--
-- Definition of trigger `upFundFromStudent`
--

DROP TRIGGER /*!50030 IF EXISTS */ `upFundFromStudent`;

DELIMITER $$

CREATE DEFINER = `root`@`localhost` TRIGGER `upFundFromStudent` BEFORE UPDATE ON `get_payment` FOR EACH ROW BEGIN
UPDATE fund
SET income = income - old.amount + new.amount
Where f_id = 1;
END $$

DELIMITER ;

--
-- Definition of trigger `delFundFromStudent`
--

DROP TRIGGER /*!50030 IF EXISTS */ `delFundFromStudent`;

DELIMITER $$

CREATE DEFINER = `root`@`localhost` TRIGGER `delFundFromStudent` BEFORE DELETE ON `get_payment` FOR EACH ROW BEGIN
UPDATE fund
set income = income - old.amount
where f_id = 1;
END $$

DELIMITER ;

--
-- Definition of table `other_expense`
--

DROP TABLE IF EXISTS `other_expense`;
CREATE TABLE `other_expense` (
  `e_id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(45) NOT NULL,
  `amount` double NOT NULL,
  `e_date` date NOT NULL,
  PRIMARY KEY  (`e_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `other_expense`
--

/*!40000 ALTER TABLE `other_expense` DISABLE KEYS */;
INSERT INTO `other_expense` (`e_id`,`name`,`amount`,`e_date`) VALUES 
 (1,'Paper Expense',1000,'2019-01-01'),
 (2,'Pen Expense',100,'2019-01-02'),
 (3,'pen',100,'2019-01-01');
/*!40000 ALTER TABLE `other_expense` ENABLE KEYS */;


--
-- Definition of trigger `insertFundExpense`
--

DROP TRIGGER /*!50030 IF EXISTS */ `insertFundExpense`;

DELIMITER $$

CREATE DEFINER = `root`@`localhost` TRIGGER `insertFundExpense` BEFORE INSERT ON `other_expense` FOR EACH ROW BEGIN
update fund
set expense = expense + new.amount
where f_id = 3;
END $$

DELIMITER ;

--
-- Definition of table `result`
--

DROP TABLE IF EXISTS `result`;
CREATE TABLE `result` (
  `rid` int(10) unsigned NOT NULL auto_increment,
  `e_id` int(10) unsigned NOT NULL,
  `e_name` varchar(45) NOT NULL,
  `s_id` int(10) unsigned NOT NULL,
  `s_name` varchar(45) NOT NULL,
  `t_marks` varchar(45) NOT NULL,
  `o_marks` varchar(45) NOT NULL,
  `gpa` varchar(45) NOT NULL,
  `grade` varchar(45) NOT NULL,
  PRIMARY KEY  USING BTREE (`rid`),
  KEY `FK_result_2` (`s_id`),
  KEY `FK_result_1` (`e_id`),
  CONSTRAINT `FK_result_1` FOREIGN KEY (`e_id`) REFERENCES `exam` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_result_2` FOREIGN KEY (`s_id`) REFERENCES `student` (`s_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `result`
--

/*!40000 ALTER TABLE `result` DISABLE KEYS */;
INSERT INTO `result` (`rid`,`e_id`,`e_name`,`s_id`,`s_name`,`t_marks`,`o_marks`,`gpa`,`grade`) VALUES 
 (1,1,'Model Test',1,'Sayem','100','85','5.00','A+'),
 (2,1,'Model Test',2,'Sajid','100','80','5.00','A+');
/*!40000 ALTER TABLE `result` ENABLE KEYS */;


--
-- Definition of table `student`
--

DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `s_id` int(10) unsigned NOT NULL default '0',
  `name` varchar(45) NOT NULL,
  `class` varchar(30) NOT NULL,
  `address` varchar(45) NOT NULL,
  `contact` varchar(20) NOT NULL,
  `batch` varchar(45) NOT NULL,
  `a_date` date NOT NULL,
  `s_group` varchar(45) NOT NULL,
  `gender` varchar(45) NOT NULL,
  PRIMARY KEY  (`s_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `student`
--

/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` (`s_id`,`name`,`class`,`address`,`contact`,`batch`,`a_date`,`s_group`,`gender`) VALUES 
 (1,'Sayem','Masters','Munshuganj','01929587477','Batch-1','2019-03-23','JAVA','Male'),
 (2,'Sajid','Honours','Munshiganj','01979587477','Batch-3','2019-01-01','Networking','Male'),
 (3,'Sayma','Intermediate','Munshiganj','01939587477','Batch-2','2019-01-01','Web Design','Female'),
 (4,'Yeasmin','Ten','Munshiganj','01939587477','Batch-2','2019-01-01','Web Design','Female'),
 (5,'Salam','Eight','Munshiganj','01988214421','Batch-4','2019-01-02','Basic Computer','Male'),
 (6,'Ayesha','Masters','Munshiganj','01988214421','Batch-3','2019-01-02','Networking','Female'),
 (7,'Susmita','Masters','Munshiganj','01988214421','Batch-1','2019-01-02','JAVA','Female'),
 (8,'Rajib','Masters','Munshiganj','01988326565','Batch-3','2019-01-03','Web Design','Male'),
 (9,'Helal','Masters','Narayanganj','01988326565','Batch-1','2019-01-03','JAVA','Male'),
 (10,'Iftekkhar','Masters','Gazipur','01988326565','Batch-1','2019-01-03','JAVA','Male'),
 (11,'Faysal','Masters','Abdullahpur','01988326565','Batch-1','2019-01-03','JAVA','Male'),
 (12,'Moshiur','Masters','Dhaka','01988326565','Batch-1','2019-01-03','JAVA','Male'),
 (13,'Basar','Masters','Dhaka','01988326565','Batch-1','2019-01-03','JAVA','Male'),
 (14,'Rony','Masters','Munshiganj','01988326565','Batch-4','2019-01-03','Basic Computer','Male'),
 (15,'Rakib','Masters','Munshiganj','01988326565','Batch-3','2019-01-03','Web Design','Male'),
 (20,'Sayem Sikder','Masters','Munshiganj','01929587477','Batch-2','2019-01-01','JAVA','Male');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;


--
-- Definition of table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `t_id` int(10) unsigned NOT NULL default '0',
  `name` varchar(45) NOT NULL,
  `address` varchar(45) NOT NULL,
  `subject_name` varchar(45) NOT NULL,
  `contact` int(10) unsigned NOT NULL,
  `gender` varchar(45) NOT NULL,
  `ad_date` date NOT NULL,
  PRIMARY KEY  (`t_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `teacher`
--

/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
INSERT INTO `teacher` (`t_id`,`name`,`address`,`subject_name`,`contact`,`gender`,`ad_date`) VALUES 
 (1,'Mahbub Sir','Dhaka','Networking',1989798564,'Male','2019-02-01'),
 (2,'Bari Sir','Dhaka','Java',1989798564,'Male','2019-02-01'),
 (3,'Nazmul Sir','Dhaka','Java',1989798564,'Male','2019-02-01'),
 (4,'Nishat Mam','Munshiganj','Basic Computer',1989798564,'Female','2019-02-01'),
 (5,'Razia Mam','Munshiganj','Basic Computer',1989798564,'Female','2019-02-01');
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;


--
-- Definition of table `teacher_login`
--

DROP TABLE IF EXISTS `teacher_login`;
CREATE TABLE `teacher_login` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `tusername` varchar(45) NOT NULL,
  `tpassword` varchar(45) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `teacher_login`
--

/*!40000 ALTER TABLE `teacher_login` DISABLE KEYS */;
INSERT INTO `teacher_login` (`id`,`tusername`,`tpassword`) VALUES 
 (2,'Sayem','123'),
 (3,'BariSir','123');
/*!40000 ALTER TABLE `teacher_login` ENABLE KEYS */;


--
-- Definition of table `teacher_payment`
--

DROP TABLE IF EXISTS `teacher_payment`;
CREATE TABLE `teacher_payment` (
  `tp_id` int(10) unsigned NOT NULL auto_increment,
  `t_id` int(10) unsigned NOT NULL,
  `name` varchar(45) NOT NULL,
  `p_month` varchar(45) NOT NULL,
  `amount` double NOT NULL,
  `p_date` date NOT NULL,
  PRIMARY KEY  (`tp_id`),
  KEY `FK_teacher_payment_tpid` (`t_id`),
  CONSTRAINT `FK_teacher_payment_tpid` FOREIGN KEY (`t_id`) REFERENCES `teacher` (`t_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `teacher_payment`
--

/*!40000 ALTER TABLE `teacher_payment` DISABLE KEYS */;
INSERT INTO `teacher_payment` (`tp_id`,`t_id`,`name`,`p_month`,`amount`,`p_date`) VALUES 
 (1,1,'Mahbub Sir','january',35000,'2019-01-01'),
 (2,2,'Bari Sir','January',60000,'2019-01-01'),
 (3,1,'Mahbub Sir','january',40000,'2019-01-01');
/*!40000 ALTER TABLE `teacher_payment` ENABLE KEYS */;


--
-- Definition of trigger `insertFundTeacher`
--

DROP TRIGGER /*!50030 IF EXISTS */ `insertFundTeacher`;

DELIMITER $$

CREATE DEFINER = `root`@`localhost` TRIGGER `insertFundTeacher` BEFORE INSERT ON `teacher_payment` FOR EACH ROW BEGIN
update fund
set expense = expense + new.amount
where f_id = 2;
END $$

DELIMITER ;

--
-- Definition of trigger `upFundFromTeacher`
--

DROP TRIGGER /*!50030 IF EXISTS */ `upFundFromTeacher`;

DELIMITER $$

CREATE DEFINER = `root`@`localhost` TRIGGER `upFundFromTeacher` BEFORE UPDATE ON `teacher_payment` FOR EACH ROW BEGIN
update fund
set expense = expense - old.amount + new.amount
where f_id = 2;
END $$

DELIMITER ;

--
-- Definition of trigger `delFundFromTeacher`
--

DROP TRIGGER /*!50030 IF EXISTS */ `delFundFromTeacher`;

DELIMITER $$

CREATE DEFINER = `root`@`localhost` TRIGGER `delFundFromTeacher` BEFORE DELETE ON `teacher_payment` FOR EACH ROW BEGIN
UPDATE fund
set expense = expense - old.amount
where f_id=2;
END $$

DELIMITER ;

--
-- Definition of procedure `allStudentsId`
--

DROP PROCEDURE IF EXISTS `allStudentsId`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `allStudentsId`()
BEGIN
select s_id from student;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `allStudentsName`
--

DROP PROCEDURE IF EXISTS `allStudentsName`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `allStudentsName`()
BEGIN
select distinct name from student;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `allTeachersId`
--

DROP PROCEDURE IF EXISTS `allTeachersId`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `allTeachersId`()
BEGIN
select t_id from teacher;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `allTeachersName`
--

DROP PROCEDURE IF EXISTS `allTeachersName`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `allTeachersName`()
BEGIN
select name from teacher;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `classStu`
--

DROP PROCEDURE IF EXISTS `classStu`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `classStu`()
BEGIN
select distinct class from student;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `delStudentPayment`
--

DROP PROCEDURE IF EXISTS `delStudentPayment`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delStudentPayment`(pid integer)
BEGIN
Delete From get_payment
Where p_id=pid;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `delTeacherPayment`
--

DROP PROCEDURE IF EXISTS `delTeacherPayment`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delTeacherPayment`(pid integer, tid integer)
BEGIN
Delete from teacher_payment
where t_id=tid && tp_id=pid;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `expense`
--

DROP PROCEDURE IF EXISTS `expense`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `expense`(nam varchar(45), amnt double, edt date)
BEGIN
insert into other_expense (name, amount, e_date)
values (nam, amnt, edt);
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `fundBalance`
--

DROP PROCEDURE IF EXISTS `fundBalance`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fundBalance`()
BEGIN
select sum(income)-sum(expense) from fund;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `getAllAdminAccId`
--

DROP PROCEDURE IF EXISTS `getAllAdminAccId`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllAdminAccId`()
BEGIN
select id from admin_login;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `getAllAdminAccount`
--

DROP PROCEDURE IF EXISTS `getAllAdminAccount`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllAdminAccount`(aid integer)
BEGIN
select * from admin_login
where id = aid;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `getAllPaymentStudent`
--

DROP PROCEDURE IF EXISTS `getAllPaymentStudent`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllPaymentStudent`(id integer)
BEGIN
select * from get_payment where s_id = id;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `getAllPaymentTeacher`
--

DROP PROCEDURE IF EXISTS `getAllPaymentTeacher`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllPaymentTeacher`(id integer)
BEGIN
select * from teacher_payment where t_id = id;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `getAllStudentPayment`
--

DROP PROCEDURE IF EXISTS `getAllStudentPayment`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllStudentPayment`()
BEGIN
select * from get_payment;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `getAllTeacherAccId`
--

DROP PROCEDURE IF EXISTS `getAllTeacherAccId`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllTeacherAccId`()
BEGIN
select id from teacher_login;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `getAllTeacherAccount`
--

DROP PROCEDURE IF EXISTS `getAllTeacherAccount`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllTeacherAccount`(tid integer)
BEGIN
select * from teacher_login
where id = tid;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `getAllTeacherPayment`
--

DROP PROCEDURE IF EXISTS `getAllTeacherPayment`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllTeacherPayment`()
BEGIN
select * from teacher_payment;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `getExpenseByDate`
--

DROP PROCEDURE IF EXISTS `getExpenseByDate`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getExpenseByDate`(dt1 date, dt2 date)
BEGIN
select * from teacher_payment where p_date >= dt1 AND p_date <= dt2;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `getIncomeByDate`
--

DROP PROCEDURE IF EXISTS `getIncomeByDate`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getIncomeByDate`(dt1 date, dt2 date)
BEGIN
select * from get_payment where p_date >= dt1 AND p_date <= dt2;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `getOExpenseByDate`
--

DROP PROCEDURE IF EXISTS `getOExpenseByDate`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getOExpenseByDate`(dt1 date, dt2 date)
BEGIN
select * from other_expense where e_date >= dt1 AND e_date <= dt2;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `getPayment`
--

DROP PROCEDURE IF EXISTS `getPayment`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPayment`(id integer, nam varchar(45), mnth varchar(45), amnt double, pdt date)
BEGIN
insert into get_payment(s_id, name, p_month, amount, p_date)
values (id, nam, mnth, amnt, pdt);
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `getPaymentInfo`
--

DROP PROCEDURE IF EXISTS `getPaymentInfo`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPaymentInfo`(sid integer)
BEGIN
select name, p_month, amount, p_date
from get_payment
where s_id=sid;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `getStudentByBatch`
--

DROP PROCEDURE IF EXISTS `getStudentByBatch`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getStudentByBatch`(btch varchar(45))
BEGIN
select * from student where batch=btch;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `getStudentByClass`
--

DROP PROCEDURE IF EXISTS `getStudentByClass`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getStudentByClass`(cls varchar(45))
BEGIN
select * from student where class=cls;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `getStudentByGender`
--

DROP PROCEDURE IF EXISTS `getStudentByGender`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getStudentByGender`(gen varchar(45))
BEGIN
select * from student where gender=gen;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `getStudentByGroup`
--

DROP PROCEDURE IF EXISTS `getStudentByGroup`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getStudentByGroup`(grp varchar(45))
BEGIN
select * from student where s_group=grp;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `getStudentByName`
--

DROP PROCEDURE IF EXISTS `getStudentByName`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getStudentByName`(nam varchar(45))
BEGIN
select * from student where name = nam;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `getStudentInfo`
--

DROP PROCEDURE IF EXISTS `getStudentInfo`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getStudentInfo`(sid integer)
BEGIN
select * from student where s_id = sid;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `getStudentPaymentByMonth`
--

DROP PROCEDURE IF EXISTS `getStudentPaymentByMonth`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getStudentPaymentByMonth`(mnth varchar(20))
BEGIN
select s_id, name, p_month, amount, p_date
from get_payment
where lower(p_month) = lower(mnth);
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `getStuPayDueByMonth`
--

DROP PROCEDURE IF EXISTS `getStuPayDueByMonth`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getStuPayDueByMonth`(mnth varchar(20))
BEGIN
select s_id, name from student
where s_id not in (
select s_id from get_payment where lower(p_month)=lower(mnth)
);
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `getTeacherByGender`
--

DROP PROCEDURE IF EXISTS `getTeacherByGender`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getTeacherByGender`(gen varchar(45))
BEGIN
select * from teacher
where gender = gen;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `getTeacherByName`
--

DROP PROCEDURE IF EXISTS `getTeacherByName`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getTeacherByName`(nam VARCHAR(45))
BEGIN
select * from teacher
where name = nam;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `getTeacherBySubject`
--

DROP PROCEDURE IF EXISTS `getTeacherBySubject`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getTeacherBySubject`(sbjct varchar(45))
BEGIN
select * from teacher
where subject_name = sbjct;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `getTeacherInfo`
--

DROP PROCEDURE IF EXISTS `getTeacherInfo`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getTeacherInfo`(tid integer)
BEGIN
select * from teacher where t_id = tid;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `getTeacherPayByMonth`
--

DROP PROCEDURE IF EXISTS `getTeacherPayByMonth`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getTeacherPayByMonth`(mnth varchar(20))
BEGIN
select * from teacher_payment where lower(p_month)=lower(mnth);
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `getTeacherPayInfo`
--

DROP PROCEDURE IF EXISTS `getTeacherPayInfo`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getTeacherPayInfo`(tid integer)
BEGIN
select name, p_month, amount, p_date
from teacher_payment
where t_id=tid;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `getTeacherPaymentByDate`
--

DROP PROCEDURE IF EXISTS `getTeacherPaymentByDate`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getTeacherPaymentByDate`(dt date)
BEGIN
select * from teacher_payment where p_date = dt;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `getTransactionByDate`
--

DROP PROCEDURE IF EXISTS `getTransactionByDate`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getTransactionByDate`(dt date)
BEGIN
select * from get_payment where p_date = dt;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `getTrPayDueByMonth`
--

DROP PROCEDURE IF EXISTS `getTrPayDueByMonth`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getTrPayDueByMonth`(mnth varchar(20))
BEGIN
select t_id, name from teacher where t_id not in(
  select t_id from teacher_payment where lower(p_month)= lower(mnth)
);
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `insertAdminLogin`
--

DROP PROCEDURE IF EXISTS `insertAdminLogin`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertAdminLogin`(uname varchar(45), pw varchar(45))
BEGIN
insert into admin_login(ausername, apassword)
values(uname, pw);
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `insertTeacherLogin`
--

DROP PROCEDURE IF EXISTS `insertTeacherLogin`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertTeacherLogin`(uname varchar(45), pw varchar(45))
BEGIN
insert into teacher_login(tusername, tpassword)
values(uname, pw);
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `paymentDueStudent`
--

DROP PROCEDURE IF EXISTS `paymentDueStudent`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `paymentDueStudent`()
BEGIN
select * from student s
where s_id not in(select s_id from get_payment);
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `paymentDueTeacher`
--

DROP PROCEDURE IF EXISTS `paymentDueTeacher`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `paymentDueTeacher`()
BEGIN
select * from teacher
where t_id not in(select t_id from teacher_payment);
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `paymentGiverStudent`
--

DROP PROCEDURE IF EXISTS `paymentGiverStudent`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `paymentGiverStudent`()
BEGIN
select s.s_id, s.name, s.class, s.address, s.contact, s.batch, s.a_date, s.s_group, s.gender
from student s inner join get_payment p
on s.s_id = p.s_id;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `paymentTakerTeacher`
--

DROP PROCEDURE IF EXISTS `paymentTakerTeacher`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `paymentTakerTeacher`()
BEGIN
select t.t_id, t.name, t.address, t.subject_name, t.contact, t.gender, t.ad_date
from teacher t inner join teacher_payment p
on t.t_id = p.t_id;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `remAdminAccount`
--

DROP PROCEDURE IF EXISTS `remAdminAccount`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `remAdminAccount`(aid integer)
BEGIN
delete from admin_login
where id = aid;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `removeStudent`
--

DROP PROCEDURE IF EXISTS `removeStudent`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `removeStudent`(sid integer)
BEGIN
DELETE from student where s_id=sid;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `removeTeacher`
--

DROP PROCEDURE IF EXISTS `removeTeacher`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `removeTeacher`(tid integer)
BEGIN
DELETE from teacher where t_id=tid;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `remTeacherAccount`
--

DROP PROCEDURE IF EXISTS `remTeacherAccount`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `remTeacherAccount`(tid Integer)
BEGIN
delete from teacher_login
where id = tid;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `saveStudent`
--

DROP PROCEDURE IF EXISTS `saveStudent`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveStudent`(id integer, nam VARCHAR(30), cls varchar(30), addrs varchar(40), cntact varchar(11), btch varchar(20), dt Date, grp varchar(45), gndr Varchar(45))
BEGIN
insert into student(s_id, name, class, address, contact, batch, a_date, s_group, gender)
values (id, nam, cls, addrs, cntact, btch, dt, grp, gndr);
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `saveTeacher`
--

DROP PROCEDURE IF EXISTS `saveTeacher`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveTeacher`(tid integer, nam varchar(30), addrs varchar(40), subjct varchar(40), cntact integer, gndr varchar(45), dt date)
BEGIN
insert into teacher(t_id, name, address, subject_name, contact, gender, ad_date)
values(tid, nam, addrs, subjct, cntact, gndr, dt);
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `searchBatch`
--

DROP PROCEDURE IF EXISTS `searchBatch`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `searchBatch`()
BEGIN
select distinct batch from student;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `showAllStudent`
--

DROP PROCEDURE IF EXISTS `showAllStudent`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `showAllStudent`()
BEGIN
select * from student;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `showAllTeacher`
--

DROP PROCEDURE IF EXISTS `showAllTeacher`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `showAllTeacher`()
BEGIN
select * from teacher;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `showAllTransaction`
--

DROP PROCEDURE IF EXISTS `showAllTransaction`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `showAllTransaction`()
BEGIN
select * from fund;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `subjectofTeachers`
--

DROP PROCEDURE IF EXISTS `subjectofTeachers`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `subjectofTeachers`()
BEGIN
select distinct subject_name from teacher;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sumPayAmount`
--

DROP PROCEDURE IF EXISTS `sumPayAmount`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sumPayAmount`(tid integer)
BEGIN
select sum(amount) from teacher_payment where t_id=tid;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sumPayAmountStudent`
--

DROP PROCEDURE IF EXISTS `sumPayAmountStudent`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sumPayAmountStudent`(sid integer)
BEGIN
select sum(amount) from get_payment where s_id=sid;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sumPayMonth`
--

DROP PROCEDURE IF EXISTS `sumPayMonth`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sumPayMonth`(tid integer)
BEGIN
select group_concat(p_month) from teacher_payment where t_id=tid;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `sumPayMonthStudent`
--

DROP PROCEDURE IF EXISTS `sumPayMonthStudent`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sumPayMonthStudent`(tid integer)
BEGIN
select group_concat(p_month) from get_payment where s_id=tid;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `teacherPayment`
--

DROP PROCEDURE IF EXISTS `teacherPayment`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `teacherPayment`(id integer, nam varchar(45), mnth varchar(45), amnt double, pdt date)
BEGIN
insert into teacher_payment(t_id, name, p_month, amount, p_date)
values(id, nam, mnth, amnt, pdt);
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `totalExpense`
--

DROP PROCEDURE IF EXISTS `totalExpense`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `totalExpense`()
BEGIN
select sum(expense) from fund;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `totalIncome`
--

DROP PROCEDURE IF EXISTS `totalIncome`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `totalIncome`()
BEGIN
select sum(income) from fund;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `totalPayStudent`
--

DROP PROCEDURE IF EXISTS `totalPayStudent`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `totalPayStudent`()
BEGIN
select sum(amount) from get_payment;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `totalPayTeacher`
--

DROP PROCEDURE IF EXISTS `totalPayTeacher`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `totalPayTeacher`()
BEGIN
select sum(amount) from teacher_payment;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `totalStudent`
--

DROP PROCEDURE IF EXISTS `totalStudent`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `totalStudent`()
BEGIN
select count(s_id) from student;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `upStudent`
--

DROP PROCEDURE IF EXISTS `upStudent`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `upStudent`(id integer, nam VARCHAR(30), cls varchar(30), addrs varchar(40), cntact varchar(11), btch varchar(20), grp varchar(45), gndr Varchar(45))
BEGIN
update student
set name=nam, class=cls, address=addrs, contact=cntact, batch=btch, s_group=grp, gender=gndr
where s_id=id; 
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `upStudentPayment`
--

DROP PROCEDURE IF EXISTS `upStudentPayment`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `upStudentPayment`(pid integer, sid integer, nam VARCHAR(30), mnth varchar(30), amnt double, dt varchar(11))
BEGIN
update get_payment
set name=nam, p_month=mnth, amount=amnt, p_date=dt
where p_id=pid && s_id=sid;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `upTeacher`
--

DROP PROCEDURE IF EXISTS `upTeacher`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `upTeacher`(id integer, nam VARCHAR(30), addrs varchar(40), subjct varchar(20), cntact varchar(11), gndr Varchar(45))
BEGIN
update teacher
set name=nam, address=addrs, subject_name=subjct, contact=cntact, gender=gndr
where t_id=id;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `upTeacherPayment`
--

DROP PROCEDURE IF EXISTS `upTeacherPayment`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `upTeacherPayment`(pid integer, tid integer, nam varchar(40), pmnth varchar(40), amnt double, pdt date)
BEGIN
update teacher_payment
set name=nam, p_month=pmnth, amount=amnt, p_date=pdt
where t_id=tid && tp_id=pid;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
