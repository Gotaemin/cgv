
-- DCL

use cgv;
commit;

-- DDL

DROP TABLE `user`;
DROP TABLE `auth2`;

DROP TABLE `member`;
DROP TABLE `auth`;
DROP TABLE `movieInfo`;
DROP TABLE `movieImage`;
DROP TABLE `movieVideo`;
DROP TABLE `review`;
DROP TABLE `cinema`;
DROP TABLE `theater`;
DROP TABLE `movieTime`;
DROP TABLE `movieAndCinema`;
DROP TABLE `movieAndTheater`;
DROP TABLE `payment`;
DROP TABLE `seat`;
DROP TABLE `seatSpace`;
DROP TABLE `seatBooking`;

CREATE TABLE `member` (
  `username` varchar(50),
  `password` varchar(100) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `birth` varchar(10) DEFAULT NULL,
  `phone` varchar(13) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `gender` tinyint(1) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `nick` varchar(20) DEFAULT NULL,
  `fileName` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) default 1,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `user` (
  `username` varchar(50),
  `password` varchar(100) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `birth` varchar(10) DEFAULT NULL,
  `phone` varchar(13) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `gender` tinyint(1) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `nick` varchar(20) DEFAULT NULL,
  `fileName` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) default 1,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `auth2` (
  `username` varchar(50),
  `auth` varchar(100) DEFAULT NULL,
  KEY `AUTH_MEMBERNUM_FK_idx` (`username`),
  CONSTRAINT `AUTH2_USERNAME_FK` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `auth` (
  `username` varchar(50),
  `auth` varchar(50) DEFAULT NULL,
   KEY `AUTH_USERNAMENUM_FK_idx` (`username`),
  CONSTRAINT `AUTH_USERNAME_FK` FOREIGN KEY (`username`) REFERENCES `member` (`username`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `movieInfo` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL,
  `titleEng` varchar(50) DEFAULT NULL,
  `runtime` varchar(4) DEFAULT NULL,
  `director` varchar(20) DEFAULT NULL,
  `actor` varchar(255) DEFAULT NULL,
  `ganre` varchar(255) DEFAULT NULL,
  `ageLimit` varchar(5) DEFAULT NULL,
  `country` varchar(10) DEFAULT NULL,
  `openDate` date DEFAULT NULL,
  `contents` longtext,
  `visitor` int(11) DEFAULT NULL,
  `rate` double(4,1) DEFAULT NULL,
  `errRate` double(4,1) DEFAULT NULL,
  `createAt` date DEFAULT NULL,
  `deleteAt` date DEFAULT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `movieImage` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `movieNum` int(11) DEFAULT NULL,
  `fileName` varchar(200) DEFAULT NULL,
  `originName` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`num`),
  KEY `MOVIEIMAGE_MOVIENUM_FK_idx` (`movieNum`),
  CONSTRAINT `MOVIEIMAGE_MOVIENUM_FK` FOREIGN KEY (`movieNum`) REFERENCES `movieInfo` (`num`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `movieVideo` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `movieNum` int(11) DEFAULT NULL,
  `videolink` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`num`),
  KEY `MOVIEVIDEO_MOVIENUM_FK_idx` (`movieNum`),
  CONSTRAINT `MOVIEVIDEO_MOVIENUM_FK` FOREIGN KEY (`movieNum`) REFERENCES `movieInfo` (`num`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `review` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `movieNum` int(11) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `contents` varchar(255) DEFAULT NULL,
  `like` int(11) DEFAULT NULL,
  `egg` tinyint(1) DEFAULT NULL,
  `charmPoint` tinyint(4) DEFAULT NULL,
  `emotionPoint` tinyint(4) DEFAULT NULL,
  `createAt` date DEFAULT NULL,
  `deleteAt` date DEFAULT NULL,
  PRIMARY KEY (`num`),
  KEY `REVIEW_MOVIENUM_FK_idx` (`movieNum`),
  KEY `REVIEW_USERNAME_FK_idx` (`username`),
  CONSTRAINT `REVIEW_MOVIENUM_FK` FOREIGN KEY (`movieNum`) REFERENCES `movieInfo` (`num`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `REVIEW_USERNAME_FK` FOREIGN KEY (`username`) REFERENCES `member` (`username`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `cinema` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `local` varchar(50) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `tel` varchar(13) DEFAULT NULL,
  `totalTheater` int(11) DEFAULT NULL,
  `totalSeat` int(11) DEFAULT NULL,
  `trafficInfo` longtext,
  `parkingInfo` longtext,
  `intro` longtext,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `theater` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `cinemaNum` int(11) DEFAULT NULL,
  `name` varchar(10) DEFAULT NULL,
  `seatCount` int(11) DEFAULT NULL,
  `filmType` int(11) DEFAULT NULL,
  PRIMARY KEY (`num`),
  KEY `THEATER_CINEMANUM_FK_idx` (`cinemaNum`),
  CONSTRAINT `THEATER_CINEMANUM_FK` FOREIGN KEY (`cinemaNum`) REFERENCES `cinema` (`num`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `movieAndCinema` (
  `movieNum` int(11) DEFAULT NULL,
  `cinemaNum` int(11) DEFAULT NULL,
  `screenable` tinyint(1) DEFAULT NULL,
  KEY `MOVIEANDCINEMA_MOVIENUM_FK_idx` (`movieNum`),
  KEY `MOVIEANDCINEMA_CINEMANUM_FK_idx` (`cinemaNum`),
  CONSTRAINT `MOVIEANDCINEMA_CINEMANUM_FK` FOREIGN KEY (`cinemaNum`) REFERENCES `cinema` (`num`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `MOVIEANDCINEMA_MOVIENUM_FK` FOREIGN KEY (`movieNum`) REFERENCES `movieInfo` (`num`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `movieAndTheater` (
  `movieNum` int(11) DEFAULT NULL,
  `theaterNum` int(11) DEFAULT NULL,
  KEY `MOVIEANDTHEATER_MOVIENUM_FK_idx` (`movieNum`),
  KEY `MOVIEANDTHEATER_THEATERNUM_FK_idx` (`theaterNum`),
  CONSTRAINT `MOVIEANDTHEATER_MOVIENUM_FK` FOREIGN KEY (`movieNum`) REFERENCES `movieInfo` (`num`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `MOVIEANDTHEATER_THEATERNUM_FK` FOREIGN KEY (`theaterNum`) REFERENCES `theater` (`num`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `movieTime` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `movieNum` int(11) DEFAULT NULL,
  `theaterNum` int(11) DEFAULT NULL,
  `screenDate` date DEFAULT NULL,
  `screenTime` varchar(5) DEFAULT NULL,
  `remainSeat` int(11) DEFAULT NULL,
  PRIMARY KEY (`num`),
  KEY `MOVIETIME_MOVIENUM_FK_idx` (`movieNum`),
  KEY `MOVIETIME_THEATERNUM_FK_idx` (`theaterNum`),
  CONSTRAINT `MOVIETIME_MOVIENUM_FK` FOREIGN KEY (`movieNum`) REFERENCES `movieInfo` (`num`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `MOVIETIME_THEATERNUM_FK` FOREIGN KEY (`theaterNum`) REFERENCES `theater` (`num`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `seat` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `theaterNum` int(11) DEFAULT NULL,
  `row` varchar(2) DEFAULT NULL,
  `col` varchar(2) DEFAULT NULL,
  `grade` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`num`),
  KEY `SEAT_THEATERNUM_FK_idx` (`theaterNum`),
  CONSTRAINT `SEAT_THEATERNUM_FK` FOREIGN KEY (`theaterNum`) REFERENCES `theater` (`num`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `payment` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `imp_uid` varchar(50) DEFAULT NULL,
  `merchant_uid` varchar(50) DEFAULT NULL,
  `pg` varchar(50) DEFAULT NULL,
  `pay_method` varchar(50) DEFAULT NULL,
  `apply_num` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `reservation` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `movieNum` int(11) DEFAULT NULL,
  `paymentNum` int(11) DEFAULT NULL,
  `movieTimeNum` int(11) DEFAULT NULL,
  `uid` varchar(50) DEFAULT NULL,
  `filmType` int(11) DEFAULT NULL,
  `cinemaName` varchar(10) DEFAULT NULL,
  `theaterName` varchar(10) DEFAULT NULL,
  `seats` varchar(24) DEFAULT NULL,
  `totalPrice` int(11) DEFAULT NULL,
  `common` int(11) DEFAULT NULL,
  `teenager` int(11) DEFAULT NULL,
  `preference` int(11) DEFAULT NULL,
  `createAt` DATE DEFAULT NULL,
  `deleteAt` DATE DEFAULT NULL,
  PRIMARY KEY (`num`),
  KEY `RESERVATION_MOVIENUM_FK_idx` (`movieNum`),
  CONSTRAINT `RESERVATION_MOVIENUM_FK` FOREIGN KEY (`movieNum`) REFERENCES `movieInfo` (`num`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `RESERVATION_PAYMENYNUM_FK_idx` (`paymentNum`),
  CONSTRAINT `RESERVATION_PAYMENYNUM_FK` FOREIGN KEY (`paymentNum`) REFERENCES `payment` (`num`) ON DELETE CASCADE ON UPDATE NO ACTION,
  KEY `RESERVATION_MOVIETIMENUM_FK_idx` (`movieTimeNum`),
  CONSTRAINT `RESERVATION_MOVIETIMENUM_FK` FOREIGN KEY (`movieTimeNum`) REFERENCES `movieTime` (`num`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `seatSpace` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `theaterNum` int(11) DEFAULT NULL,
  `rowOrCol` tinyint(1) DEFAULT NULL,	-- 0 : row or 1 : col
  `index` int(11) DEFAULT NULL,
  PRIMARY KEY (`num`),
  KEY `SEATSPACE_SEATNUM_FK_idx` (`theaterNum`),
  CONSTRAINT `SEATSPACE_SEATNUM_FK` FOREIGN KEY (`theaterNum`) REFERENCES `theater` (`num`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `seatBooking` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `seatNum` int(11) DEFAULT NULL,
  `movieTimeNum` int(11) DEFAULT NULL,
  `reservationNum` int(11) DEFAULT NULL,
  PRIMARY KEY (`num`),
  KEY `SEATBOOKING_SEATNUM_FK_idx` (`seatNum`),
  KEY `SEATBOOKING_MOVIETIMENUM_FK_idx` (`movieTimeNum`),
  KEY `SEATBOOKING_RESERVATIONNUM_FK_idx` (`reservationNum`),
  CONSTRAINT `SEATBOOKING_SEATNUM_FK` FOREIGN KEY (`seatNum`) REFERENCES `seat` (`num`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `SEATBOOKING_MOVIETIMENUM_FK` FOREIGN KEY (`movieTimeNum`) REFERENCES `movieTime` (`num`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `SEATBOOKING_RESERVATIONNUM_FK` FOREIGN KEY (`reservationNum`) REFERENCES `reservation` (`num`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

-- memberSQL

SELECT * FROM 
(SELECT * FROM member) M
LEFT OUTER JOIN 
(SELECT * FROM auth) A
ON(M.num = A.memberNum);

select * from 
(select num as mNum,title from movieInfo) M
join
(select num as tNum, movieNum, theaterNum,screenDate,screenTime  from movieTime) T
on(M.mNum = T.movieNum);
  
SELECT * FROM 
(SELECT * FROM user WHERE username = 'admin') M
LEFT OUTER JOIN 
(SELECT * FROM auth2) A
ON(M.username = A.username);
  
SELECT * FROM cinema WHERE local = "서울" limit 2,2;
