-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 12, 2025 at 10:09 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `puma`
--

-- --------------------------------------------------------

--
-- Table structure for table `cabinets`
--

CREATE TABLE `cabinets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `term_start` varchar(255) NOT NULL,
  `term_end` varchar(255) NOT NULL,
  `status` enum('active','archived') NOT NULL DEFAULT 'active',
  `description` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cabinets`
--

INSERT INTO `cabinets` (`id`, `name`, `term_start`, `term_end`, `status`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Kaustav', '2024', '2025', 'active', 'PUMA Informatics Cabinet for the 2024-2025 academic year.', '2025-03-12 02:06:41', '2025-03-12 02:06:41');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `divisions`
--

CREATE TABLE `divisions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `divisions`
--

INSERT INTO `divisions` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'External Relation', 'Responsible for handling external affairs and collaborations.', '2025-03-12 02:06:10', '2025-03-12 02:06:10'),
(2, 'Internal Relation', 'Manages internal affairs and maintains good relationships within the organization.', '2025-03-12 02:06:10', '2025-03-12 02:06:10'),
(3, 'Student Academic and Competition', 'Focuses on academic development and competitions.', '2025-03-12 02:06:10', '2025-03-12 02:06:10'),
(4, 'Informative and Creative Media', 'Handles media, publications, and creative content.', '2025-03-12 02:06:10', '2025-03-12 02:06:10'),
(5, 'Research and Technology', 'Engages in research, development, and technology-related initiatives.', '2025-03-12 02:06:10', '2025-03-12 02:06:10'),
(6, 'Technopreneur', 'Combines technology and entrepreneurship for innovative solutions.', '2025-03-12 02:06:10', '2025-03-12 02:06:10'),
(7, 'Human Resource and Development', 'Manages HR tasks, training, and development of members.', '2025-03-12 02:06:10', '2025-03-12 02:06:10'),
(8, 'Student Passions and Talents', 'Encourages and supports students in pursuing their talents and interests.', '2025-03-12 02:06:10', '2025-03-12 02:06:10'),
(9, 'Board of Director', 'Oversees the organization and its strategic direction.', '2025-03-12 02:06:10', '2025-03-12 02:06:10');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `date` datetime NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE `members` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `position` varchar(255) NOT NULL,
  `batch` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('Admin','Member') NOT NULL DEFAULT 'Member',
  `status` enum('current','alumni') NOT NULL DEFAULT 'current',
  `joined_at` date NOT NULL,
  `left_at` date DEFAULT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `members`
--

INSERT INTO `members` (`id`, `name`, `position`, `batch`, `email`, `phone`, `password`, `role`, `status`, `joined_at`, `left_at`, `profile_image`, `created_at`, `updated_at`) VALUES
(1, 'Abdurrahman Khairi', '-', '-', 'abdurrahmankhairi@example.com', NULL, '$2y$12$HdceSvjG2fNLyLxmEnWv2uozZh9EYijAJJ2BwmWXYpTOGKyFPSopC', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:11', '2025-03-12 02:06:11'),
(2, 'Filbert Sembiring Meliala', '-', '-', 'filbertsembiringmeliala@example.com', NULL, '$2y$12$dzyEvA0FKDrFvTtrotiaPuVOCxOzQu45RZl3LuyBHXrN36kSD6IjW', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:12', '2025-03-12 02:06:12'),
(3, 'Leonardo Dos Santos', '-', '-', 'leonardodossantos@example.com', NULL, '$2y$12$U9DG/TbQ48xEkQEh0H.F0.QnyZVVpy0sGGfo8V0cK7Q.OHPT2.cFq', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:12', '2025-03-12 02:06:12'),
(4, 'Moshe Dayan', '-', '-', 'moshedayan@example.com', NULL, '$2y$12$vLO86YnCkvPwTof2CP7DwugWvAoqderSiuAKcHVPZzjNwz1RwWdQW', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:13', '2025-03-12 02:06:13'),
(5, 'Elvia Aptanisa', '-', '-', 'elviaaptanisa@example.com', NULL, '$2y$12$zSgr6pCr.l1FvZUrfY9BgOshKhNirmo.DzaDGPvm5sWKhf4xfs7R.', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:14', '2025-03-12 02:06:14'),
(6, 'Michelle', '-', '-', 'michelle@example.com', NULL, '$2y$12$XprezYLCv5W6sBw1ns5aTuXZHF4/3nGVu1B.G4I9do96Dhjxz3bM.', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:14', '2025-03-12 02:06:14'),
(7, 'Desy Nursalsabila', '-', '-', 'desynursalsabila@example.com', NULL, '$2y$12$sWz8pIDidJBTinGmLMvxweM8KyWUfhVFImJwXwTODzCa8tzNdFiq6', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:15', '2025-03-12 02:06:15'),
(8, 'Putri Zahara', '-', '-', 'putrizahara@example.com', NULL, '$2y$12$qe9SrYCTdlcKXhgNGFhuzeFl.kV4z8EVLQC6et2TaIXIh6WRFF5wq', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:15', '2025-03-12 02:06:15'),
(9, 'Zuldan Fahrizal Rahman', '-', '-', 'zuldanfahrizalrahman@example.com', NULL, '$2y$12$9wrGg9/QcC3.atMy9J4zWOp3kArToO9GRwv39gUofu2uSToCYdDFS', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:16', '2025-03-12 02:06:16'),
(10, 'Isya Maghfira Zalfa', '-', '-', 'isyamaghfirazalfa@example.com', NULL, '$2y$12$hCIvf5FpCYHSPRa/CQ4d1.eGOY2zvTR959mubCTMpYHtPcsIrEtoe', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:16', '2025-03-12 02:06:16'),
(11, 'Sarahwati', '-', '-', 'sarahwati@example.com', NULL, '$2y$12$swe.u5KFLujuHV73I9yhkujmiHbgG.ccfE31CppEDnBiZe2i7S3B6', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:17', '2025-03-12 02:06:17'),
(12, 'Shanty', '-', '-', 'shanty@example.com', NULL, '$2y$12$BydzeC33gWaQp36tvXn.OOWf3OzMAgWT2FeKboajiB2Oz44WXnleS', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:17', '2025-03-12 02:06:17'),
(13, 'Naufal Rizki Pinugroho', '-', '-', 'naufalrizkipinugroho@example.com', NULL, '$2y$12$y.UcoBk8GELt1tNJ/EnPIOa1DlmKKALKiDT1/yDSiv1eEfikHp10a', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:18', '2025-03-12 02:06:18'),
(14, 'Made Mas Pradnya Prabawa', '-', '-', 'mademaspradnyaprabawa@example.com', NULL, '$2y$12$LlLYGbhNesny8NXU2YvahOku6Pn4xmY1XHLyTYdGC0DAugW6TeL5.', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:18', '2025-03-12 02:06:18'),
(15, 'Gideon Anggara Siagian', '-', '-', 'gideonanggarasiagian@example.com', NULL, '$2y$12$o0PYTN.Qaa7tL3sEfs8JGeq7Z0yveE1wV/hug9Z7TyK8gz2FJUp.G', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:19', '2025-03-12 02:06:19'),
(16, 'Bianca Vallerie', '-', '-', 'biancavallerie@example.com', NULL, '$2y$12$52IkcP6g.IlvUlmnQ1PO0.ngQtr4Nib5qjMeBGi1.iE1P0ujfEyx.', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:19', '2025-03-12 02:06:19'),
(17, 'Abigail Tiara Larasati', '-', '-', 'abigailtiaralarasati@example.com', NULL, '$2y$12$yK1PdBZ9f35R2PDm9.DhNe7VbdiQztcdcJhMAHEtEA3JM6nPqa0o.', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:19', '2025-03-12 02:06:19'),
(18, 'Johana Veronica Setiawan', '-', '-', 'johanaveronicasetiawan@example.com', NULL, '$2y$12$IVH9RyZz7pKCL/cc0dAt0OHLFuU5hmbLATKRYD482l70Ry7G3TTnS', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:20', '2025-03-12 02:06:20'),
(19, 'Muhammad Dzaki Abrar', '-', '-', 'muhammaddzakiabrar@example.com', NULL, '$2y$12$YT6rQva1qq7D2mm.V1K5SO0I9DjAqYbTyWaIcKdZmnFDx8j8XSuK.', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:20', '2025-03-12 02:06:20'),
(20, 'Zain Akbar', '-', '-', 'zainakbar@example.com', NULL, '$2y$12$heTd6NIHmYPI4JEV7CsvS.5msrgFMJAC4B0XLvt4YLJUwyyHwiyyO', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:21', '2025-03-12 02:06:21'),
(21, 'Hana Khairunnisa Nabiilah', '-', '-', 'hanakhairunnisanabiilah@example.com', NULL, '$2y$12$F/4toedop6975kyRFCw1NuZcR53HAqiVQnsxH3giFBTpqrQYW0v8K', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:21', '2025-03-12 02:06:21'),
(22, 'Sarah Kimberly Fischer', '-', '-', 'sarahkimberlyfischer@example.com', NULL, '$2y$12$WujkaCzHCaMGMzLysOdzi.5fbX/otM/bHbVHomSdh5lK0AySn5.1y', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:22', '2025-03-12 02:06:22'),
(23, 'Lutfi Maulana', '-', '-', 'lutfimaulana@example.com', NULL, '$2y$12$0ljB6L6NxKpBLOMODxwQEOX9wc6NbfzMw/5aSUAzE3WmHqb3ZsUfC', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:22', '2025-03-12 02:06:22'),
(24, 'Wilbert Leonard Harriman', '-', '-', 'wilbertleonardharriman@example.com', NULL, '$2y$12$Hr6mtAVbPm/Mmn1KmuDM4OJ/R5dg3eajOUqIbPlMEF/euB4vrpuye', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:23', '2025-03-12 02:06:23'),
(25, 'Yasmin Raihanah Inayudha', '-', '-', 'yasminraihanahinayudha@example.com', NULL, '$2y$12$ILUP.Pt3mRolBtuFaD4HK.JUMHw6CH4Zb9ZE.5o1M4dYOgm/kMvxe', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:23', '2025-03-12 02:06:23'),
(26, 'Cut Kheysa Sakbania', '-', '-', 'cutkheysasakbania@example.com', NULL, '$2y$12$MDRrFP64puAhj5Xa3At4BOctzP.CnhA1Krxbu4/4qxy9F3VrRS7E6', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:24', '2025-03-12 02:06:24'),
(27, 'Made Mahatti Prayascita Chandra', '-', '-', 'mademahattiprayascitachandra@example.com', NULL, '$2y$12$KVmqzBQCh75DO4/D9uojn.xJtRmte4T7Ek2dma7SDLxkkt7A.eb9O', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:24', '2025-03-12 02:06:24'),
(28, 'Nadifah Aulia Rahmani', '-', '-', 'nadifahauliarahmani@example.com', NULL, '$2y$12$ffKN0u18PBngfduWn6By/ejs8TdmvXwfk9/9BOhcjtVzjZMbfzaom', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:25', '2025-03-12 02:06:25'),
(29, 'Muhammad Afdal Fikri', '-', '-', 'muhammadafdalfikri@example.com', NULL, '$2y$12$1/g8P1mAcsS3LWSZ0MGP4.YEoZJmcduM2Ea4svRMH8RYtLl6K9I4S', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:25', '2025-03-12 02:06:25'),
(30, 'Gamma Ahmad Zaki Kurnia Budihardjo', '-', '-', 'gammaahmadzakikurniabudihardjo@example.com', NULL, '$2y$12$LiecLOuynlrFgm5cE8KOG.OKONICOGMufR/1v9XypvoHroWWO5yAC', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:26', '2025-03-12 02:06:26'),
(31, 'Naila Olivia', '-', '-', 'nailaolivia@example.com', NULL, '$2y$12$viln/WpSjR1MwD4WXyg43uDXp0fKazIsgVpr8IO.f6B9hacz6/uoK', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:26', '2025-03-12 02:06:26'),
(32, 'Azqa Difani Akbar', '-', '-', 'azqadifaniakbar@example.com', NULL, '$2y$12$ecjHorBThEN9ExSpqw9hXexSrx9KL4F7rKhMq4M59r/6DNI4bvOwe', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:27', '2025-03-12 02:06:27'),
(33, 'Almira Shinta Aulia', '-', '-', 'almirashintaaulia@example.com', NULL, '$2y$12$cxOQVYVGDJIKWpNK.yDgxOuZViIMxZZ7PHuargfqTdl9dEcCGM22m', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:27', '2025-03-12 02:06:27'),
(34, 'Richie Obhasa', '-', '-', 'richieobhasa@example.com', NULL, '$2y$12$qpBMwhyxHVqXVlscZpxld.80NesluAM2KPTIHDNA2xvG5HrekBPIG', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:28', '2025-03-12 02:06:28'),
(35, 'Gabriel Hamonangan Lumban Tobing', '-', '-', 'gabrielhamonanganlumbantobing@example.com', NULL, '$2y$12$spuCaa1xc.ZPVB/6SSqabe.e9SLsnK73kKrPbjzQdYZnRBZlhlpiq', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:28', '2025-03-12 02:06:28'),
(36, 'Raisya Eka Putri', '-', '-', 'raisyaekaputri@example.com', NULL, '$2y$12$kYQpgDVDian/s5r0QD/FtO5CB2XbcXyg.QJdbNp5eiiKS/ZZBC3qG', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:29', '2025-03-12 02:06:29'),
(37, 'Kevin Syonin', '-', '-', 'kevinsyonin@example.com', NULL, '$2y$12$IABrLuGITooijw3e32pqVe77VojE9xPQp0mGS7o3LCeKFMsi7s/2u', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:29', '2025-03-12 02:06:29'),
(38, 'Dewa Anggara Satria Pratama', '-', '-', 'dewaanggarasatriapratama@example.com', NULL, '$2y$12$Py0/yRbT0ZAY29avXwaZKOI956/BDeqXzF8jz4zUYfbknQtxR19eO', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:30', '2025-03-12 02:06:30'),
(39, 'Rix Valdo', '-', '-', 'rixvaldo@example.com', NULL, '$2y$12$B0jY9Sa4J.RrsIdA6.RyzOZS4wiwoqI.CyqT08AyvqwD7m73ElAK2', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:31', '2025-03-12 02:06:31'),
(40, 'Jason Anthony Wibowo', '-', '-', 'jasonanthonywibowo@example.com', NULL, '$2y$12$4UA9Ns/YcsW/lPsNSXegBe1PRMIhTFfYr7KDKl2kOSNHwLuVC7bXi', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:31', '2025-03-12 02:06:31'),
(41, 'Muhammad Haikal Islami', '-', '-', 'muhammadhaikalislami@example.com', NULL, '$2y$12$iL8439YQGLttU.SgaPMPKOg0N/A3bbYR9B2iPKB1eP/1MG05c1Vny', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:32', '2025-03-12 02:06:32'),
(42, 'Briant Jasper', '-', '-', 'briantjasper@example.com', NULL, '$2y$12$/EWrTIniR3UqZ7Wnmr1NhOHGzpWlXbocnYtc1Yo0F4HWCUie5Yhu2', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:32', '2025-03-12 02:06:32'),
(43, 'Keira Nevrada Lay', '-', '-', 'keiranevradalay@example.com', NULL, '$2y$12$xZGAO9Qup7gqiz458RgybOwcsGFrQtZgkP8nBjusPnilA.Ovx6pSy', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:33', '2025-03-12 02:06:33'),
(44, 'Janet Dewi Evangeline', '-', '-', 'janetdewievangeline@example.com', NULL, '$2y$12$92r.vwA4FCbdvayyEl1.4OO5X0hNmBjZUBNPyVonMiJQMgit9LDNa', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:33', '2025-03-12 02:06:33'),
(45, 'Nisrina Izza Nur Aisyah', '-', '-', 'nisrinaizzanuraisyah@example.com', NULL, '$2y$12$cDKD6eUdaaTF3qmNTIDZQOaPGVkr6l9lv2Z32SaLdF2Y/z7H4cNJ6', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:34', '2025-03-12 02:06:34'),
(46, 'Ubaidillah Al-Azhar', '-', '-', 'ubaidillahal-azhar@example.com', NULL, '$2y$12$8C/yMTnDtL3LrNORq8mLE.SI8gpI7Afvhq1/USb7wZloPS5sjrvUi', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:34', '2025-03-12 02:06:34'),
(47, 'Salsa Ica Indriani', '-', '-', 'salsaicaindriani@example.com', NULL, '$2y$12$wQ/p6DorZyA4t6Q1KJKDHeajbZ1q639EDlltg1wtfckIKt3KdeEZ.', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:35', '2025-03-12 02:06:35'),
(48, 'Navisa Ersa Sabina', '-', '-', 'navisaersasabina@example.com', NULL, '$2y$12$XOvK7KK8lbV/bwQF0HcIpeH8c53mu9kgG0WS6OzTNwRJ3nVV9SwOG', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:35', '2025-03-12 02:06:35'),
(49, 'Michael Bryan Mandey', '-', '-', 'michaelbryanmandey@example.com', NULL, '$2y$12$TDAlppPKbBqJIodi1cyXweffBYTkOs3xZQgwlPE8sTZRIkaTw7bC.', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:36', '2025-03-12 02:06:36'),
(50, 'Nailha Sakhila Dewi', '-', '-', 'nailhasakhiladewi@example.com', NULL, '$2y$12$9/ZkysiBkqqkZN31aA67B.y34uFa9j/Wu.HcswcTFgPnLnhWI7rQS', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:36', '2025-03-12 02:06:36'),
(51, 'Joy Adelia Sihombing', '-', '-', 'joyadeliasihombing@example.com', NULL, '$2y$12$IKDW0M5yp1yLulemjpsPRushVkXqt6XgkO47rhXLTdfsW42PvCofi', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:37', '2025-03-12 02:06:37'),
(52, 'Intan Kumala Pasya', '-', '-', 'intankumalapasya@example.com', NULL, '$2y$12$zgbY0c8a2hpOAicJnszDBuknGt7QJgxjJgCUzgSpNgundNa4cNPoO', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:37', '2025-03-12 02:06:37'),
(53, 'Tio Muhammad Rizky', '-', '-', 'tiomuhammadrizky@example.com', NULL, '$2y$12$7V.Oq/W9p2N/Ah0GVBiwmuolcrP1iRyWOgUu9zHDMe4UzpD/zd39i', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:38', '2025-03-12 02:06:38'),
(54, 'Angelina Yolanda Christin Lubis', '-', '-', 'angelinayolandachristinlubis@example.com', NULL, '$2y$12$akNOGGC5zGQneZGdQulaxOFMVT6yZILK4SO8nufz9lnzCv.QAjcTC', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:38', '2025-03-12 02:06:38'),
(55, 'Ernest Teo', '-', '-', 'ernestteo@example.com', NULL, '$2y$12$WXf5198mrjBxJGqTsRG8E.qMMUV4SDppqwmLQgsl7LjhEkOZC59.m', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:39', '2025-03-12 02:06:39'),
(56, 'Rivan Meinaki', '-', '-', 'rivanmeinaki@example.com', NULL, '$2y$12$k9LWa8L0GakckQAc9hCP9Oc97TeqGoReIz8ApImW2jTsC7jSKy/CK', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:39', '2025-03-12 02:06:39'),
(57, 'Wisnu Alfian Nur Ashar', '-', '-', 'wisnualfiannurashar@example.com', NULL, '$2y$12$I2dlP6ckLrC0eH1gOTKAo./OAyYySUqS7o.QL5.86NYzcF0nTfYNS', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:40', '2025-03-12 02:06:40'),
(58, 'Fauzan Fajri', '-', '-', 'fauzanfajri@example.com', NULL, '$2y$12$khy4QBNUGegCF.9PEJKO/.SHjaMV5WBp8Nd4aeiI3n9I1..RPEVZm', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:40', '2025-03-12 02:06:40'),
(59, 'Qwyn Celine Djimondo', '-', '-', 'qwyncelinedjimondo@example.com', NULL, '$2y$12$M.mNuIlu0g1rxSRriyzjw.yLZNNf6lwonpTgEeiXdNCsHbsZ.0VK2', 'Member', 'current', '2025-03-12', NULL, NULL, '2025-03-12 02:06:41', '2025-03-12 02:06:41');

-- --------------------------------------------------------

--
-- Table structure for table `member_details`
--

CREATE TABLE `member_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `member_id` bigint(20) UNSIGNED NOT NULL,
  `cabinet_id` bigint(20) UNSIGNED NOT NULL,
  `division_id` bigint(20) UNSIGNED DEFAULT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `member_details`
--

INSERT INTO `member_details` (`id`, `member_id`, `cabinet_id`, `division_id`, `role_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, 1, '2025-03-12 02:06:41', '2025-03-12 02:06:41'),
(2, 2, 1, NULL, 2, '2025-03-12 02:06:41', '2025-03-12 02:06:41'),
(3, 3, 1, NULL, 3, '2025-03-12 02:06:41', '2025-03-12 02:06:41'),
(4, 4, 1, NULL, 4, '2025-03-12 02:06:41', '2025-03-12 02:06:41'),
(5, 5, 1, NULL, 5, '2025-03-12 02:06:41', '2025-03-12 02:06:41'),
(6, 6, 1, NULL, 5, '2025-03-12 02:06:41', '2025-03-12 02:06:41'),
(7, 7, 1, NULL, 6, '2025-03-12 02:06:41', '2025-03-12 02:06:41'),
(8, 8, 1, NULL, 7, '2025-03-12 02:06:41', '2025-03-12 02:06:41'),
(9, 9, 1, NULL, 7, '2025-03-12 02:06:41', '2025-03-12 02:06:41');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_03_12_000003_create_members_table', 1),
(5, '2025_03_12_041924_create_events_table', 1),
(6, '2025_03_12_041935_create_news_table', 1),
(7, '2025_03_12_041951_create_divisions_table', 1),
(8, '2025_03_12_065151_create_cabinets_table', 1),
(9, '2025_03_12_070643_create_roles_table', 1),
(10, '2025_03_12_071706_create_member_details_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE `news` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `img_url` varchar(255) NOT NULL,
  `member_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` enum('Chairperson','Vice Chairperson I','Vice Chairperson II','Senior Treasurer','Junior Treasurer','Senior Secretary','Junior Secretary','HoD','VoD','Member') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Chairperson', NULL, NULL),
(2, 'Vice Chairperson I', NULL, NULL),
(3, 'Vice Chairperson II', NULL, NULL),
(4, 'Senior Treasurer', NULL, NULL),
(5, 'Junior Treasurer', NULL, NULL),
(6, 'Senior Secretary', NULL, NULL),
(7, 'Junior Secretary', NULL, NULL),
(8, 'HoD', NULL, NULL),
(9, 'VoD', NULL, NULL),
(10, 'Member', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Test User', 'test@example.com', '2025-03-12 02:06:41', '$2y$12$8AGGU5hajsdGwGhGifzoLODdRhfvPHaZ8mbJcXTXBU7qR2GMATkDy', 'Osnb3kPnEh', '2025-03-12 02:06:42', '2025-03-12 02:06:42');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cabinets`
--
ALTER TABLE `cabinets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cabinets_name_unique` (`name`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `divisions`
--
ALTER TABLE `divisions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `divisions_name_unique` (`name`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `members`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `members_email_unique` (`email`);

--
-- Indexes for table `member_details`
--
ALTER TABLE `member_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_details_member_id_foreign` (`member_id`),
  ADD KEY `member_details_cabinet_id_foreign` (`cabinet_id`),
  ADD KEY `member_details_division_id_foreign` (`division_id`),
  ADD KEY `member_details_role_id_foreign` (`role_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`),
  ADD KEY `news_member_id_foreign` (`member_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cabinets`
--
ALTER TABLE `cabinets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `divisions`
--
ALTER TABLE `divisions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `members`
--
ALTER TABLE `members`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `member_details`
--
ALTER TABLE `member_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `news`
--
ALTER TABLE `news`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `member_details`
--
ALTER TABLE `member_details`
  ADD CONSTRAINT `member_details_cabinet_id_foreign` FOREIGN KEY (`cabinet_id`) REFERENCES `cabinets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `member_details_division_id_foreign` FOREIGN KEY (`division_id`) REFERENCES `divisions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `member_details_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `member_details_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `news`
--
ALTER TABLE `news`
  ADD CONSTRAINT `news_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
