CREATE TABLE IF NOT EXISTS %%BOARD%% ( 
  doc_id int unsigned NOT NULL auto_increment, 
  media_id int unsigned NOT NULL DEFAULT '0', 
  poster_ip decimal(39,0) unsigned NOT NULL DEFAULT '0', 
  num int unsigned NOT NULL, 
  subnum int unsigned NOT NULL, 
  thread_num int unsigned NOT NULL DEFAULT '0', 
  op bool NOT NULL DEFAULT '0', 
  timestamp int unsigned NOT NULL, 
  timestamp_expired int unsigned NOT NULL, 
  preview_orig varchar(20), 
  preview_w smallint unsigned NOT NULL DEFAULT '0', 
  preview_h smallint unsigned NOT NULL DEFAULT '0', 
  media_filename text, 
  media_w smallint unsigned NOT NULL DEFAULT '0', 
  media_h smallint unsigned NOT NULL DEFAULT '0', 
  media_size int unsigned NOT NULL DEFAULT '0', 
  media_hash varchar(25), 
  media_orig varchar(20), 
  spoiler bool NOT NULL DEFAULT '0', 
  deleted bool NOT NULL DEFAULT '0', 
  capcode enum('N', 'M', 'A', 'G') NOT NULL DEFAULT 'N', 
  email varchar(100), 
  name varchar(100), 
  trip varchar(25), 
  title varchar(100), 
  comment text,
  delpass tinytext, 
  sticky bool NOT NULL DEFAULT '0', 
  poster_hash varchar(8), 
  exif text, 
  
  PRIMARY KEY (doc_id), 
  UNIQUE num_subnum_index (num, subnum), 
  INDEX poster_ip_index(poster_ip), 
  INDEX media_id_index(media_id),
  INDEX num_index(num), 
  INDEX subnum_index(subnum),
  INDEX thread_num_index(thread_num),
  INDEX op_index(op),
  INDEX timestamp_index(timestamp),
  INDEX timestamp_expired_index(timestamp),
  INDEX media_hash_index(media_hash),
  INDEX media_filename_index(media_filename(255)),
  INDEX email_index(email),
  INDEX name_index(name),
  INDEX trip_index(trip),
  INDEX fullname_index(name,trip)
) engine=InnoDB	 CHARSET=%%CHARSET%%;

CREATE TABLE IF NOT EXISTS `%%BOARD%%_threads` (
  `thread_num` int unsigned NOT NULL,
  `time_op` int unsigned NOT NULL,
  `time_last` int unsigned NOT NULL,
  `time_bump` int unsigned NOT NULL,
  `time_ghost` int unsigned DEFAULT NULL,
  `time_ghost_bump` int unsigned DEFAULT NULL,
  `nreplies` int unsigned NOT NULL DEFAULT '0',
  `nimages` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`thread_num`),
  
  INDEX time_op_index (time_op),
  INDEX time_bump_index (time_bump),					
  INDEX time_ghost_bump_index (time_ghost_bump)
) ENGINE=InnoDB CHARSET=%%CHARSET%%;

CREATE TABLE IF NOT EXISTS `%%BOARD%%_users` (
  `user_id` int unsigned NOT NULL auto_increment,
  `name` varchar(100) NOT NULL DEFAULT '',
  `trip` varchar(25) NOT NULL DEFAULT '',
  `firstseen` int(11) NOT NULL,
  `postcount` int(11) NOT NULL,
  PRIMARY KEY (`user_id`),
  
  UNIQUE name_trip_index (`name`, `trip`),
  INDEX firstseen_index (firstseen),
  INDEX postcount_index (postcount)
) ENGINE=InnoDB DEFAULT CHARSET=%%CHARSET%%;

CREATE TABLE IF NOT EXISTS `%%BOARD%%_images` (
  `media_id` int unsigned NOT NULL auto_increment,
  `media_hash` varchar(25) NOT NULL,
  `media` varchar(20),
  `preview_op` varchar(20),
  `preview_reply` varchar(20),
  `total` int(10) unsigned NOT NULL DEFAULT '0',
  `banned` smallint unsigned NOT NULL DEFAULT '0', 
  PRIMARY KEY (`media_id`),
  UNIQUE media_hash_index (`media_hash`),
  INDEX total_index (total)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%%BOARD%%_daily` (
  `day` int(10) unsigned NOT NULL,
  `posts` int(10) unsigned NOT NULL,
  `images` int(10) unsigned NOT NULL,
  `sage` int(10) unsigned NOT NULL,
  `anons` int(10) unsigned NOT NULL,
  `trips` int(10) unsigned NOT NULL,
  `names` int(10) unsigned NOT NULL,
  PRIMARY KEY (`day`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;