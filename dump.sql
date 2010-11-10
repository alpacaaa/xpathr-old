-- phpMyAdmin SQL Dump
-- version 2.11.3deb1ubuntu1.3
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generato il: 10 Nov, 2010 at 03:35 AM
-- Versione MySQL: 5.0.51
-- Versione PHP: 5.2.4-2ubuntu5.10

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `ninja`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `sym_authors`
--

CREATE TABLE IF NOT EXISTS `sym_authors` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `username` varchar(20) collate utf8_unicode_ci NOT NULL default '',
  `password` varchar(40) collate utf8_unicode_ci NOT NULL,
  `first_name` varchar(100) collate utf8_unicode_ci default NULL,
  `last_name` varchar(100) collate utf8_unicode_ci default NULL,
  `email` varchar(255) collate utf8_unicode_ci default NULL,
  `last_seen` datetime default '0000-00-00 00:00:00',
  `user_type` enum('author','developer') collate utf8_unicode_ci NOT NULL default 'author',
  `primary` enum('yes','no') collate utf8_unicode_ci NOT NULL default 'no',
  `default_section` int(11) NOT NULL,
  `auth_token_active` enum('yes','no') collate utf8_unicode_ci NOT NULL default 'no',
  `language` varchar(15) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dump dei dati per la tabella `sym_authors`
--

INSERT INTO `sym_authors` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `last_seen`, `user_type`, `primary`, `default_section`, `auth_token_active`, `language`) VALUES
(1, 'admin', '4ecb9d2b21439d3e2d139b23358140cfa6f14203', 'Marco', 'Sampellegrini', 'm@rcosa.mp', '2010-11-09 12:05:50', 'developer', 'yes', 6, 'no', NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `sym_cache`
--

CREATE TABLE IF NOT EXISTS `sym_cache` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `hash` varchar(32) collate utf8_unicode_ci NOT NULL default '',
  `creation` int(14) NOT NULL default '0',
  `expiry` int(14) unsigned default NULL,
  `data` longtext collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `creation` (`creation`),
  KEY `hash` (`hash`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dump dei dati per la tabella `sym_cache`
--

INSERT INTO `sym_cache` (`id`, `hash`, `creation`, `expiry`, `data`) VALUES
(1, '_session_config', 1286179787, NULL, 'eJwzBAAAMgAy');

-- --------------------------------------------------------

--
-- Struttura della tabella `sym_entries`
--

CREATE TABLE IF NOT EXISTS `sym_entries` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `section_id` int(11) unsigned NOT NULL,
  `author_id` int(11) unsigned NOT NULL,
  `creation_date` datetime NOT NULL,
  `creation_date_gmt` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `section_id` (`section_id`),
  KEY `author_id` (`author_id`),
  KEY `creation_date` (`creation_date`),
  KEY `creation_date_gmt` (`creation_date_gmt`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=9 ;

--
-- Dump dei dati per la tabella `sym_entries`
--

INSERT INTO `sym_entries` (`id`, `section_id`, `author_id`, `creation_date`, `creation_date_gmt`) VALUES
(8, 1, 1, '2010-10-17 12:30:25', '2010-10-17 10:30:25');

-- --------------------------------------------------------

--
-- Struttura della tabella `sym_entries_data_1`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_1` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) default NULL,
  `value` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=120 ;

--
-- Dump dei dati per la tabella `sym_entries_data_1`
--

INSERT INTO `sym_entries_data_1` (`id`, `entry_id`, `handle`, `value`) VALUES
(119, 8, 'ebf38sjf73', 'ebf38sjf73');

-- --------------------------------------------------------

--
-- Struttura della tabella `sym_entries_data_2`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_2` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) default NULL,
  `value` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=120 ;

--
-- Dump dei dati per la tabella `sym_entries_data_2`
--

INSERT INTO `sym_entries_data_2` (`id`, `entry_id`, `handle`, `value`) VALUES
(119, 8, 'test', 'Test');

-- --------------------------------------------------------

--
-- Struttura della tabella `sym_entries_data_3`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_3` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `value` text,
  `value_formatted` text,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  FULLTEXT KEY `value` (`value`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=120 ;

--
-- Dump dei dati per la tabella `sym_entries_data_3`
--

INSERT INTO `sym_entries_data_3` (`id`, `entry_id`, `value`, `value_formatted`) VALUES
(119, 8, 'A way too cool description.', NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `sym_entries_data_4`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_4` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) default NULL,
  `value` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=90 ;

--
-- Dump dei dati per la tabella `sym_entries_data_4`
--

INSERT INTO `sym_entries_data_4` (`id`, `entry_id`, `handle`, `value`) VALUES
(89, 8, 'stronzoxml', 'stronzo.xml');

-- --------------------------------------------------------

--
-- Struttura della tabella `sym_entries_data_5`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_5` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) default NULL,
  `value` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=114 ;

--
-- Dump dei dati per la tabella `sym_entries_data_5`
--

INSERT INTO `sym_entries_data_5` (`id`, `entry_id`, `handle`, `value`) VALUES
(113, 8, 'piustronzoxsl', 'piustronzo.xsl');

-- --------------------------------------------------------

--
-- Struttura della tabella `sym_extensions`
--

CREATE TABLE IF NOT EXISTS `sym_extensions` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `status` enum('enabled','disabled') collate utf8_unicode_ci NOT NULL default 'enabled',
  `version` varchar(20) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=10 ;

--
-- Dump dei dati per la tabella `sym_extensions`
--

INSERT INTO `sym_extensions` (`id`, `name`, `status`, `version`) VALUES
(3, 'data_store', 'disabled', '1.0'),
(2, 'debugdevkit', 'enabled', '1.0.8'),
(4, 'symquery', 'enabled', '0.1.0'),
(5, 'profiledevkit', 'enabled', '1.0.4'),
(9, 'domdoc_xmlelement', 'enabled', '1.0');

-- --------------------------------------------------------

--
-- Struttura della tabella `sym_extensions_delegates`
--

CREATE TABLE IF NOT EXISTS `sym_extensions_delegates` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `extension_id` int(11) NOT NULL,
  `page` varchar(100) collate utf8_unicode_ci NOT NULL,
  `delegate` varchar(100) collate utf8_unicode_ci NOT NULL,
  `callback` varchar(100) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `extension_id` (`extension_id`),
  KEY `page` (`page`),
  KEY `delegate` (`delegate`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=10 ;

--
-- Dump dei dati per la tabella `sym_extensions_delegates`
--

INSERT INTO `sym_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES
(1, 2, '/frontend/', 'FrontendDevKitResolve', 'frontendDevKitResolve'),
(2, 2, '/frontend/', 'ManipulateDevKitNavigation', 'manipulateDevKitNavigation'),
(3, 5, '/frontend/', 'FrontendDevKitResolve', 'frontendDevKitResolve'),
(4, 5, '/frontend/', 'ManipulateDevKitNavigation', 'manipulateDevKitNavigation'),
(5, 5, '/frontend/', 'FrontendOutputPostGenerate', 'FrontendOutputPostGenerate'),
(9, 9, '/frontend/', 'FrontendOutputPostGenerate', 'FrontendOutputPostGenerate');

-- --------------------------------------------------------

--
-- Struttura della tabella `sym_fields`
--

CREATE TABLE IF NOT EXISTS `sym_fields` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `label` varchar(255) collate utf8_unicode_ci NOT NULL,
  `element_name` varchar(50) collate utf8_unicode_ci NOT NULL,
  `type` varchar(32) collate utf8_unicode_ci NOT NULL,
  `parent_section` int(11) NOT NULL default '0',
  `required` enum('yes','no') collate utf8_unicode_ci NOT NULL default 'yes',
  `sortorder` int(11) NOT NULL default '1',
  `location` enum('main','sidebar') collate utf8_unicode_ci NOT NULL default 'main',
  `show_column` enum('yes','no') collate utf8_unicode_ci NOT NULL default 'no',
  PRIMARY KEY  (`id`),
  KEY `index` (`element_name`,`type`,`parent_section`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

--
-- Dump dei dati per la tabella `sym_fields`
--

INSERT INTO `sym_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES
(1, 'uniq-id', 'uniq-id', 'input', 1, 'yes', 0, 'main', 'yes'),
(2, 'Title', 'title', 'input', 1, 'no', 1, 'main', 'yes'),
(3, 'Description', 'description', 'textarea', 1, 'no', 2, 'main', 'no'),
(4, 'Main XML file', 'main-xml-file', 'input', 1, 'no', 3, 'main', 'yes'),
(5, 'Main XSL file', 'main-xsl-file', 'input', 1, 'no', 4, 'main', 'yes');

-- --------------------------------------------------------

--
-- Struttura della tabella `sym_fields_author`
--

CREATE TABLE IF NOT EXISTS `sym_fields_author` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `field_id` int(11) unsigned NOT NULL,
  `allow_author_change` enum('yes','no') collate utf8_unicode_ci NOT NULL,
  `allow_multiple_selection` enum('yes','no') collate utf8_unicode_ci NOT NULL default 'no',
  `default_to_current_user` enum('yes','no') collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `field_id` (`field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `sym_fields_author`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `sym_fields_checkbox`
--

CREATE TABLE IF NOT EXISTS `sym_fields_checkbox` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `field_id` int(11) unsigned NOT NULL,
  `default_state` enum('on','off') collate utf8_unicode_ci NOT NULL default 'on',
  `description` varchar(255) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `sym_fields_checkbox`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `sym_fields_date`
--

CREATE TABLE IF NOT EXISTS `sym_fields_date` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `field_id` int(11) unsigned NOT NULL,
  `pre_populate` enum('yes','no') collate utf8_unicode_ci NOT NULL default 'no',
  PRIMARY KEY  (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `sym_fields_date`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `sym_fields_input`
--

CREATE TABLE IF NOT EXISTS `sym_fields_input` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `field_id` int(11) unsigned NOT NULL,
  `validator` varchar(255) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=11 ;

--
-- Dump dei dati per la tabella `sym_fields_input`
--

INSERT INTO `sym_fields_input` (`id`, `field_id`, `validator`) VALUES
(7, 1, NULL),
(8, 2, NULL),
(9, 4, NULL),
(10, 5, NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `sym_fields_select`
--

CREATE TABLE IF NOT EXISTS `sym_fields_select` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `field_id` int(11) unsigned NOT NULL,
  `allow_multiple_selection` enum('yes','no') collate utf8_unicode_ci NOT NULL default 'no',
  `static_options` text collate utf8_unicode_ci,
  `dynamic_options` int(11) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `sym_fields_select`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `sym_fields_taglist`
--

CREATE TABLE IF NOT EXISTS `sym_fields_taglist` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `field_id` int(11) unsigned NOT NULL,
  `validator` varchar(255) collate utf8_unicode_ci default NULL,
  `pre_populate_source` varchar(15) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`),
  KEY `field_id` (`field_id`),
  KEY `pre_populate_source` (`pre_populate_source`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `sym_fields_taglist`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `sym_fields_textarea`
--

CREATE TABLE IF NOT EXISTS `sym_fields_textarea` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `field_id` int(11) unsigned NOT NULL,
  `formatter` varchar(100) collate utf8_unicode_ci default NULL,
  `size` int(3) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dump dei dati per la tabella `sym_fields_textarea`
--

INSERT INTO `sym_fields_textarea` (`id`, `field_id`, `formatter`, `size`) VALUES
(3, 3, NULL, 7);

-- --------------------------------------------------------

--
-- Struttura della tabella `sym_fields_upload`
--

CREATE TABLE IF NOT EXISTS `sym_fields_upload` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `field_id` int(11) unsigned NOT NULL,
  `destination` varchar(255) collate utf8_unicode_ci NOT NULL,
  `validator` varchar(255) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `sym_fields_upload`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `sym_forgotpass`
--

CREATE TABLE IF NOT EXISTS `sym_forgotpass` (
  `author_id` int(11) NOT NULL default '0',
  `token` varchar(6) collate utf8_unicode_ci NOT NULL,
  `expiry` varchar(25) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`author_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dump dei dati per la tabella `sym_forgotpass`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `sym_pages`
--

CREATE TABLE IF NOT EXISTS `sym_pages` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `parent` int(11) default NULL,
  `title` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `handle` varchar(255) collate utf8_unicode_ci default NULL,
  `path` varchar(255) collate utf8_unicode_ci default NULL,
  `params` varchar(255) collate utf8_unicode_ci default NULL,
  `data_sources` text collate utf8_unicode_ci,
  `events` text collate utf8_unicode_ci,
  `sortorder` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `parent` (`parent`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=11 ;

--
-- Dump dei dati per la tabella `sym_pages`
--

INSERT INTO `sym_pages` (`id`, `parent`, `title`, `handle`, `path`, `params`, `data_sources`, `events`, `sortorder`) VALUES
(1, NULL, 'Snippet', 'snippet', NULL, 'user/snip-id/resource/type', NULL, NULL, 2),
(2, NULL, 'Snippet Edit', 'edit', NULL, 'snip-id', 'resources_list,snippet_information,snippet_main_resources,snippet_parameters', 'save_main_resources,save_snippet_information', 3),
(3, 2, 'Edit Resource', 'resource', 'edit', 'snip-id/resource', 'resources_list,snippet_information,snippet_resource_encoded', 'delete_resource,save_resource,save_snippet_information', 4),
(4, 2, 'Edit Parameters', 'parameters', 'edit', 'snip-id', 'resources_list,snippet_information,snippet_parameters', 'save_parameters,save_snippet_information', 5),
(5, 2, 'Add Resource', 'add-resource', 'edit', 'snip-id', 'resources_list,snippet_information', 'add_resource,save_snippet_information', 6),
(6, 2, 'Process Result', 'result', 'edit', 'snip-id', 'resources_list,snippet_information,snippet_result', 'save_snippet_information', 7),
(8, NULL, 'Snippet View', 'view', NULL, 'user/snip-id', 'resources_list,snippet_information,snippet_main_resources', NULL, 8),
(9, 8, 'View Resource', 'resource', 'view', 'user/snip-id/resource', 'resources_list,snippet_information,snippet_resource_bitter', NULL, 9),
(10, 8, 'View Result', 'result', 'view', 'user/snip-id', 'resources_list,snippet_information,snippet_result', NULL, 10);

-- --------------------------------------------------------

--
-- Struttura della tabella `sym_pages_types`
--

CREATE TABLE IF NOT EXISTS `sym_pages_types` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `page_id` int(11) unsigned NOT NULL,
  `type` varchar(50) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `page_id` (`page_id`,`type`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dump dei dati per la tabella `sym_pages_types`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `sym_sections`
--

CREATE TABLE IF NOT EXISTS `sym_sections` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `handle` varchar(255) collate utf8_unicode_ci NOT NULL,
  `sortorder` int(11) NOT NULL default '0',
  `entry_order` varchar(7) collate utf8_unicode_ci default NULL,
  `entry_order_direction` enum('asc','desc') collate utf8_unicode_ci default 'asc',
  `hidden` enum('yes','no') collate utf8_unicode_ci NOT NULL default 'no',
  `navigation_group` varchar(255) collate utf8_unicode_ci NOT NULL default 'Content',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `handle` (`handle`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dump dei dati per la tabella `sym_sections`
--

INSERT INTO `sym_sections` (`id`, `name`, `handle`, `sortorder`, `entry_order`, `entry_order_direction`, `hidden`, `navigation_group`) VALUES
(1, 'Snippets', 'snippets', 1, NULL, 'asc', 'no', 'Content');

-- --------------------------------------------------------

--
-- Struttura della tabella `sym_sections_association`
--

CREATE TABLE IF NOT EXISTS `sym_sections_association` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `parent_section_id` int(11) unsigned NOT NULL,
  `parent_section_field_id` int(11) unsigned default NULL,
  `child_section_id` int(11) unsigned NOT NULL,
  `child_section_field_id` int(11) unsigned NOT NULL,
  `cascading_deletion` enum('yes','no') collate utf8_unicode_ci NOT NULL default 'no',
  PRIMARY KEY  (`id`),
  KEY `parent_section_id` (`parent_section_id`,`child_section_id`,`child_section_field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `sym_sections_association`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `sym_sessions`
--

CREATE TABLE IF NOT EXISTS `sym_sessions` (
  `session` varchar(255) NOT NULL,
  `session_expires` int(10) unsigned NOT NULL default '0',
  `session_data` text,
  PRIMARY KEY  (`session`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `sym_sessions`
--

INSERT INTO `sym_sessions` (`session`, `session_expires`, `session_data`) VALUES
('dcce79f90a6812bfd446d29e5c36042b', 1289300750, 'sym-|a:2:{s:8:"username";s:5:"admin";s:4:"pass";s:40:"4ecb9d2b21439d3e2d139b23358140cfa6f14203";}');

