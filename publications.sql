-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1
-- Время создания: Ноя 03 2016 г., 07:56
-- Версия сервера: 10.1.13-MariaDB
-- Версия PHP: 5.6.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `publications`
--

-- --------------------------------------------------------

--
-- Структура таблицы `ads`
--

CREATE TABLE `ads` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `heading` varchar(100) NOT NULL,
  `text` varchar(1000) NOT NULL,
  `expirationdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` tinyint(3) UNSIGNED NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `type_id` tinyint(1) UNSIGNED NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `ads`
--

INSERT INTO `ads` (`id`, `heading`, `text`, `expirationdate`, `user_id`, `date`, `type_id`) VALUES
(6, 'Величайшее событие года', 'Джозеф Тайлор (TOP) прокатился в зорбе по толпе фанатов на концерте в СПб', '2016-10-28 21:00:00', 33, '2016-10-26 07:00:52', 1),
(7, 'Продаются детские ботиночки', 'Неношеные.', '2016-10-28 21:00:00', 35, '2016-10-28 21:40:42', 1),
(11, 'Продам слона', 'Купите слона. Недорого! Без смс и регистрации', '2016-11-28 21:00:00', 35, '2016-10-29 00:23:45', 1),
(12, 'В СПБ идет зима', 'Кажется, уже пришла.', '2016-10-08 21:00:00', 35, '2016-10-29 06:17:59', 1),
(17, 'TOP продолжили тур', 'Теперь они радуют Европу своими коцертами', '2016-12-03 21:00:00', 35, '2016-10-29 06:57:05', 1),
(18, 'Заголовок', 'Текст', '2016-11-28 21:00:00', 33, '2016-10-29 11:48:48', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `articles`
--

CREATE TABLE `articles` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `heading` varchar(100) NOT NULL,
  `text` varchar(1000) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mark` float(3,1) DEFAULT NULL,
  `count` tinyint(3) DEFAULT NULL,
  `user_id` tinyint(3) UNSIGNED DEFAULT NULL,
  `authors` varchar(100) NOT NULL,
  `type_id` tinyint(1) UNSIGNED NOT NULL DEFAULT '2'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `articles`
--

INSERT INTO `articles` (`id`, `heading`, `text`, `date`, `mark`, `count`, `user_id`, `authors`, `type_id`) VALUES
(1, 'Концерт Twenty One Pilots', 'В Санкт-Петербурге прошел концерт богов.', '2016-10-25 19:54:30', 5.0, 11, 33, 'Тайлер Джозеф', 2),
(2, 'Флип назад', 'Выполнил барабанщик TOP на концерте', '2016-10-28 17:57:24', 5.0, 9, 14, 'Счастливый очевидец', 2),
(3, 'Заголовок ', 'Текст ', '2016-10-28 19:44:31', 4.0, 7, 14, 'Авторы', 2),
(4, 'Новая статья', 'Новый текст', '2016-10-29 11:53:04', 4.0, 7, 14, 'Я', 2),
(5, 'test', 'test', '2016-10-29 12:48:15', 0.8, 4, 36, 'test', 2),
(6, 'testqqq', 'dsssa', '2016-10-29 13:17:41', 0.5, 4, 36, 'dfvgvvd', 2);

-- --------------------------------------------------------

--
-- Структура таблицы `connect`
--

CREATE TABLE `connect` (
  `session` char(32) NOT NULL,
  `token` char(32) NOT NULL,
  `user_id` tinyint(3) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `connect`
--

INSERT INTO `connect` (`session`, `token`, `user_id`) VALUES
('1msejtjf8j47bnibig6w1t3il2q8f22p', '85jz854o6fbv8t265ouo5umyymv3rxjq', 17),
('1w5re6491gxjc7kv5epwrhfw2fakeqe4', 'lcd9zqa9gvqsa7t2dr4u2yrb5ra81our', 34),
('b14ysulbyodx0dheo9dt580r6kvcz5w5', '9cla8xxbmbbdoas028sc1zayawrz2s5y', 36),
('bnpxzgkoyibb9fn5cat15ojb7o1ufxzy', 'binhtzqteggq2jjm8b7axd54ktmy58b4', 33),
('d58bbr6hubshijfugnxj8dmzywe680kl', '4vy787ygo8db1pjadsccc93wzaoyxmdz', 15),
('skqa889arwfwd6yhh41u4dfdp0cv8mgq', '5a2qgmtalpy7j57ts1sz9ye2g0avcs6r', 35);

-- --------------------------------------------------------

--
-- Структура таблицы `marks`
--

CREATE TABLE `marks` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `user_id` tinyint(3) UNSIGNED NOT NULL,
  `article_id` tinyint(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `marks`
--

INSERT INTO `marks` (`id`, `user_id`, `article_id`) VALUES
(1, 33, 1),
(2, 14, 4),
(3, 14, 3),
(4, 14, 2),
(5, 36, 5),
(6, 37, 5),
(7, 17, 5),
(8, 36, 6),
(9, 15, 6),
(10, 38, 6),
(11, 38, 5),
(12, 14, 6);

-- --------------------------------------------------------

--
-- Структура таблицы `news`
--

CREATE TABLE `news` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `heading` varchar(100) NOT NULL,
  `text` varchar(1000) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `source` varchar(100) NOT NULL,
  `user_id` tinyint(3) UNSIGNED DEFAULT NULL,
  `type_id` tinyint(1) UNSIGNED DEFAULT '3'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `news`
--

INSERT INTO `news` (`id`, `heading`, `text`, `date`, `source`, `user_id`, `type_id`) VALUES
(1, 'Величайшее событие года!', 'Концерт Twenty One Pilots в России! Впервые в нашей стране.', '2016-10-25 22:34:33', 'paperpaper.ru', 33, 3),
(2, 'Событие года!', 'Первый снег в Питере\r\nНо это не повод пить', '2016-10-27 18:33:42', 'Улица', 33, 3),
(3, 'Новость дня', 'Пилоты пообещали вернуться в Россию  с концертом', '2016-10-28 22:02:23', 'Концерт', 35, 3);

-- --------------------------------------------------------

--
-- Структура таблицы `types`
--

CREATE TABLE `types` (
  `id` tinyint(1) UNSIGNED NOT NULL,
  `type` varchar(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `types`
--

INSERT INTO `types` (`id`, `type`) VALUES
(1, 'ads'),
(2, 'articles'),
(3, 'news');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `login` varchar(16) NOT NULL,
  `pass` char(32) NOT NULL,
  `name` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `login`, `pass`, `name`) VALUES
(14, '1', 'c4ca4238a0b923820dcc509a6f75849b', '1'),
(15, '2', 'c81e728d9d4c2f636f067f89cc14862c', '2'),
(16, '3', 'eccbc87e4b5ce2fe28308fd9f2a7baf3', '3'),
(17, '4', 'a87ff679a2f3e71d9181a67b7542122c', '4'),
(18, '5', 'e4da3b7fbbce2345d7772b0674a318d5', '5'),
(19, '6', '1679091c5a880faf6fb5e6087eb1b2dc', '6'),
(20, '7', '8f14e45fceea167a5a36dedd4bea2543', '7'),
(21, '8', 'c9f0f895fb98ab9159f51fd0297e236d', '8'),
(22, '10', 'd3d9446802a44259755d38e6d163e820', '10'),
(23, '11', '6512bd43d9caa6e02c990b0a82652dca', '11'),
(25, '20', '98f13708210194c475687be6106a3b84', '20'),
(26, 'Ivan', '202cb962ac59075b964b07152d234b70', 'Ivan'),
(28, 'Ivan7', '102342371ebf48c94c3659cf20805eab', 'Ivan'),
(29, 'bugaga', '6af0088fc7c444ab185664fc4625b44a', 'bugaga'),
(30, 'naf', '2a33a22558b84f226250869393917562', 'naf'),
(31, 'Tyler', '24dbc2b917472b089a5052b23f11f30f', 'Tyler Joseph'),
(32, 'Josh', 'e1271e594ea53336c212f2febc2ccdd6', 'Josh Dun'),
(33, 'TOP', '6705777b712ee811e76fb07162081d63', 'TOP'),
(34, 'Jenna', '10606b87128fc256446b8a85affa2efa', 'Jenna'),
(35, 'Anna', '97a9d330e236c8d067f01da1894a5438', 'Anna Annovna'),
(36, 'roma', '5d41402abc4b2a76b9719d911017c592', 'hello'),
(37, 'z', 'fbade9e36a3f36d3d676c1b808451dd7', 'z'),
(38, 'ye', '00c66f1a036bd8f9cb709cb8d925d3d9', 'ye'),
(39, 'v', '9e3669d19b675bd57058fd4664205d2a', 'v');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `ads`
--
ALTER TABLE `ads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `user_id_2` (`user_id`),
  ADD KEY `type` (`type_id`);

--
-- Индексы таблицы `articles`
--
ALTER TABLE `articles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `user_id_2` (`user_id`),
  ADD KEY `user_id_3` (`user_id`),
  ADD KEY `type` (`type_id`);

--
-- Индексы таблицы `connect`
--
ALTER TABLE `connect`
  ADD PRIMARY KEY (`session`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `marks`
--
ALTER TABLE `marks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `article_id` (`article_id`);

--
-- Индексы таблицы `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `type` (`type_id`);

--
-- Индексы таблицы `types`
--
ALTER TABLE `types`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `ads`
--
ALTER TABLE `ads`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT для таблицы `articles`
--
ALTER TABLE `articles`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT для таблицы `marks`
--
ALTER TABLE `marks`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT для таблицы `news`
--
ALTER TABLE `news`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `types`
--
ALTER TABLE `types`
  MODIFY `id` tinyint(1) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;
--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `ads`
--
ALTER TABLE `ads`
  ADD CONSTRAINT `ads_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ads_ibfk_2` FOREIGN KEY (`type_id`) REFERENCES `types` (`id`) ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `articles`
--
ALTER TABLE `articles`
  ADD CONSTRAINT `articles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `articles_ibfk_2` FOREIGN KEY (`type_id`) REFERENCES `types` (`id`) ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `connect`
--
ALTER TABLE `connect`
  ADD CONSTRAINT `connect_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `marks`
--
ALTER TABLE `marks`
  ADD CONSTRAINT `marks_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `marks_ibfk_2` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `news`
--
ALTER TABLE `news`
  ADD CONSTRAINT `news_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `news_ibfk_2` FOREIGN KEY (`type_id`) REFERENCES `types` (`id`) ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
