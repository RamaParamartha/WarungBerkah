-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 17, 2026 at 12:01 PM
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
-- Database: `warungberkah`
--

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--

CREATE TABLE `barang` (
  `ID_Barang` varchar(10) NOT NULL,
  `Nama_Barang` varchar(100) NOT NULL,
  `Harga_Beli` decimal(18,2) DEFAULT NULL,
  `Harga_Jual` decimal(18,2) DEFAULT NULL,
  `Stok` int(11) DEFAULT NULL,
  `Margin` decimal(18,2) GENERATED ALWAYS AS (`Harga_Jual` - `Harga_Beli`) VIRTUAL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `barang`
--

INSERT INTO `barang` (`ID_Barang`, `Nama_Barang`, `Harga_Beli`, `Harga_Jual`, `Stok`) VALUES
('B001', 'Beras Premium', 10000.00, 12000.00, 100),
('B002', 'Minyak Goreng', 14000.00, 16500.00, 50),
('B003', 'Sabun Mandi', 3000.00, 4500.00, 200),
('B004', 'Keripik Kentang', 8000.00, 11000.00, 80);

-- --------------------------------------------------------

--
-- Table structure for table `distributor`
--

CREATE TABLE `distributor` (
  `ID_Distributor` varchar(10) NOT NULL,
  `Nama_Supplier` varchar(100) NOT NULL,
  `Tahun_Mulai_Kontrak` int(11) DEFAULT NULL,
  `Jalan` varchar(100) DEFAULT NULL,
  `Kota` varchar(50) DEFAULT NULL,
  `Nomor_Kontak` varchar(50) DEFAULT NULL,
  `Detail_Cabang` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `distributor`
--

INSERT INTO `distributor` (`ID_Distributor`, `Nama_Supplier`, `Tahun_Mulai_Kontrak`, `Jalan`, `Kota`, `Nomor_Kontak`, `Detail_Cabang`) VALUES
('D001', 'PT. Sumber Makmur', 2018, 'Jl. Industri No. 1', 'Jakarta', '0812345678', 'Sukabumi, Solo, Cirebon'),
('D002', 'PT. Snack Jaya', 2020, 'Jl. Raya Snack No. 5', 'Bekasi', '0899876543', 'Depok, Bekasi');

-- --------------------------------------------------------

--
-- Table structure for table `faktur`
--

CREATE TABLE `faktur` (
  `No_Faktur` varchar(20) NOT NULL,
  `ID_Distributor` varchar(10) DEFAULT NULL,
  `Tanggal_Pesan` date DEFAULT NULL,
  `Tanggal_Terima` date DEFAULT NULL,
  `Lama_Proses_Hari` int(11) GENERATED ALWAYS AS (to_days(`Tanggal_Terima`) - to_days(`Tanggal_Pesan`)) VIRTUAL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `faktur`
--

INSERT INTO `faktur` (`No_Faktur`, `ID_Distributor`, `Tanggal_Pesan`, `Tanggal_Terima`) VALUES
('F001', 'D001', '2026-01-10', '2026-01-15'),
('F002', 'D001', '2026-02-15', '2026-02-17'),
('F003', 'D002', '2026-03-01', '2026-03-02');

-- --------------------------------------------------------

--
-- Table structure for table `rincian_faktur`
--

CREATE TABLE `rincian_faktur` (
  `ID_Rincian` int(11) NOT NULL,
  `No_Faktur` varchar(20) DEFAULT NULL,
  `ID_Barang` varchar(10) DEFAULT NULL,
  `Jumlah` int(11) DEFAULT NULL,
  `Harga_Beli_Satuan` decimal(18,2) DEFAULT NULL,
  `Subtotal` decimal(18,2) GENERATED ALWAYS AS (`Jumlah` * `Harga_Beli_Satuan`) VIRTUAL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rincian_faktur`
--

INSERT INTO `rincian_faktur` (`ID_Rincian`, `No_Faktur`, `ID_Barang`, `Jumlah`, `Harga_Beli_Satuan`) VALUES
(1, 'F001', 'B001', 10, 10000.00),
(2, 'F001', 'B002', 5, 14000.00),
(3, 'F002', 'B003', 20, 3000.00),
(4, 'F003', 'B004', 15, 8000.00);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`ID_Barang`);

--
-- Indexes for table `distributor`
--
ALTER TABLE `distributor`
  ADD PRIMARY KEY (`ID_Distributor`);

--
-- Indexes for table `faktur`
--
ALTER TABLE `faktur`
  ADD PRIMARY KEY (`No_Faktur`),
  ADD KEY `fk_distributor` (`ID_Distributor`);

--
-- Indexes for table `rincian_faktur`
--
ALTER TABLE `rincian_faktur`
  ADD PRIMARY KEY (`ID_Rincian`),
  ADD KEY `fk_faktur` (`No_Faktur`),
  ADD KEY `fk_barang` (`ID_Barang`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `rincian_faktur`
--
ALTER TABLE `rincian_faktur`
  MODIFY `ID_Rincian` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `faktur`
--
ALTER TABLE `faktur`
  ADD CONSTRAINT `fk_distributor` FOREIGN KEY (`ID_Distributor`) REFERENCES `distributor` (`ID_Distributor`);

--
-- Constraints for table `rincian_faktur`
--
ALTER TABLE `rincian_faktur`
  ADD CONSTRAINT `fk_barang` FOREIGN KEY (`ID_Barang`) REFERENCES `barang` (`ID_Barang`),
  ADD CONSTRAINT `fk_faktur` FOREIGN KEY (`No_Faktur`) REFERENCES `faktur` (`No_Faktur`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
