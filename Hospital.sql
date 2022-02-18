USE [Hospital]
GO
/****** Object:  Table [dbo].[Appointment]    Script Date: 18.02.2022 18:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Appointment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NOT NULL,
	[DoctorScheduleId] [int] NOT NULL,
	[StartTime] [time](7) NOT NULL,
	[EndTime] [time](7) NOT NULL,
 CONSTRAINT [PK_Appointment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Client]    Script Date: 18.02.2022 18:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[Patronymic] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[DateOfBirthday] [date] NOT NULL,
	[GenderCode] [nvarchar](1) NOT NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DoctorSchedule]    Script Date: 18.02.2022 18:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DoctorSchedule](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DoctorId] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[StartTime] [time](7) NOT NULL,
	[EndTime] [time](7) NOT NULL,
 CONSTRAINT [PK_DoctorSchedule] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doctor]    Script Date: 18.02.2022 18:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doctor](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[Patronymic] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[CabinetNumber] [int] NOT NULL,
	[SpecializationId] [int] NOT NULL,
	[IsActual] [bit] NOT NULL,
 CONSTRAINT [PK_Doctor] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[DoctorScheduleView]    Script Date: 18.02.2022 18:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DoctorScheduleView]
AS
SELECT        dbo.DoctorSchedule.Date, dbo.Appointment.StartTime, dbo.Appointment.EndTime, dbo.Doctor.LastName + ' ' + LEFT(dbo.Doctor.FirstName, 1) + '. ' + LEFT(dbo.Doctor.Patronymic, 1) + '.' AS DoctorInfo, dbo.Doctor.CabinetNumber, 
                         dbo.Client.LastName + ' ' + LEFT(dbo.Client.FirstName, 1) + '. ' + LEFT(dbo.Client.Patronymic, 1) + '.' AS ClientInfo
FROM            dbo.Appointment INNER JOIN
                         dbo.DoctorSchedule ON dbo.Appointment.DoctorScheduleId = dbo.DoctorSchedule.Id INNER JOIN
                         dbo.Doctor ON dbo.DoctorSchedule.DoctorId = dbo.Doctor.Id INNER JOIN
                         dbo.Client ON dbo.Appointment.ClientId = dbo.Client.Id
GO
/****** Object:  Table [dbo].[Gender]    Script Date: 18.02.2022 18:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gender](
	[Code] [nvarchar](1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Gender] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 18.02.2022 18:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Specialization]    Script Date: 18.02.2022 18:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Specialization](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Specialization] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 18.02.2022 18:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] NOT NULL,
	[Login] [nvarchar](20) NOT NULL,
	[Password] [nvarchar](20) NOT NULL,
	[RoleId] [int] NOT NULL,
	[FirstName] [nvarchar](20) NOT NULL,
	[LastName] [nvarchar](20) NOT NULL,
	[Patronymic] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Appointment] ON 

INSERT [dbo].[Appointment] ([Id], [ClientId], [DoctorScheduleId], [StartTime], [EndTime]) VALUES (1, 1, 5, CAST(N'09:00:00' AS Time), CAST(N'09:30:00' AS Time))
INSERT [dbo].[Appointment] ([Id], [ClientId], [DoctorScheduleId], [StartTime], [EndTime]) VALUES (2, 1, 1, CAST(N'09:30:00' AS Time), CAST(N'10:00:00' AS Time))
INSERT [dbo].[Appointment] ([Id], [ClientId], [DoctorScheduleId], [StartTime], [EndTime]) VALUES (3, 1, 5, CAST(N'11:00:00' AS Time), CAST(N'11:30:00' AS Time))
INSERT [dbo].[Appointment] ([Id], [ClientId], [DoctorScheduleId], [StartTime], [EndTime]) VALUES (4, 1, 5, CAST(N'09:30:00' AS Time), CAST(N'10:00:00' AS Time))
SET IDENTITY_INSERT [dbo].[Appointment] OFF
GO
SET IDENTITY_INSERT [dbo].[Client] ON 

INSERT [dbo].[Client] ([Id], [FirstName], [Patronymic], [LastName], [DateOfBirthday], [GenderCode]) VALUES (1, N'Иван', N'Иванович', N'Иванов', CAST(N'1997-04-02' AS Date), N'M')
SET IDENTITY_INSERT [dbo].[Client] OFF
GO
SET IDENTITY_INSERT [dbo].[Doctor] ON 

INSERT [dbo].[Doctor] ([Id], [FirstName], [Patronymic], [LastName], [CabinetNumber], [SpecializationId], [IsActual]) VALUES (1, N'Елена', N'Семёновна', N'Гурьба', 6, 1, 1)
INSERT [dbo].[Doctor] ([Id], [FirstName], [Patronymic], [LastName], [CabinetNumber], [SpecializationId], [IsActual]) VALUES (2, N'Татьяна', N'Ивановна', N'Шурова', 14, 1, 1)
INSERT [dbo].[Doctor] ([Id], [FirstName], [Patronymic], [LastName], [CabinetNumber], [SpecializationId], [IsActual]) VALUES (3, N'Александр', N'Анатольевич', N'Степченко', 12, 1, 1)
INSERT [dbo].[Doctor] ([Id], [FirstName], [Patronymic], [LastName], [CabinetNumber], [SpecializationId], [IsActual]) VALUES (4, N'Мария', N'Владимировна', N'Сафонова', 22, 5, 1)
INSERT [dbo].[Doctor] ([Id], [FirstName], [Patronymic], [LastName], [CabinetNumber], [SpecializationId], [IsActual]) VALUES (5, N'Евгения', N'Валерьевна', N'Медведева', 34, 4, 1)
INSERT [dbo].[Doctor] ([Id], [FirstName], [Patronymic], [LastName], [CabinetNumber], [SpecializationId], [IsActual]) VALUES (6, N'Андрей', N'Игоревич', N'Романов', 48, 3, 0)
INSERT [dbo].[Doctor] ([Id], [FirstName], [Patronymic], [LastName], [CabinetNumber], [SpecializationId], [IsActual]) VALUES (7, N'Лидия', N'Рихардовна', N'Каур', 50, 2, 0)
SET IDENTITY_INSERT [dbo].[Doctor] OFF
GO
SET IDENTITY_INSERT [dbo].[DoctorSchedule] ON 

INSERT [dbo].[DoctorSchedule] ([Id], [DoctorId], [Date], [StartTime], [EndTime]) VALUES (1, 1, CAST(N'2021-12-11' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time))
INSERT [dbo].[DoctorSchedule] ([Id], [DoctorId], [Date], [StartTime], [EndTime]) VALUES (2, 1, CAST(N'2021-12-12' AS Date), CAST(N'12:00:00' AS Time), CAST(N'21:00:00' AS Time))
INSERT [dbo].[DoctorSchedule] ([Id], [DoctorId], [Date], [StartTime], [EndTime]) VALUES (5, 1, CAST(N'2021-12-14' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time))
INSERT [dbo].[DoctorSchedule] ([Id], [DoctorId], [Date], [StartTime], [EndTime]) VALUES (6, 1, CAST(N'2021-12-15' AS Date), CAST(N'12:00:00' AS Time), CAST(N'21:00:00' AS Time))
INSERT [dbo].[DoctorSchedule] ([Id], [DoctorId], [Date], [StartTime], [EndTime]) VALUES (7, 1, CAST(N'2021-12-17' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time))
INSERT [dbo].[DoctorSchedule] ([Id], [DoctorId], [Date], [StartTime], [EndTime]) VALUES (8, 1, CAST(N'2021-12-18' AS Date), CAST(N'12:00:00' AS Time), CAST(N'21:00:00' AS Time))
INSERT [dbo].[DoctorSchedule] ([Id], [DoctorId], [Date], [StartTime], [EndTime]) VALUES (9, 2, CAST(N'2021-12-13' AS Date), CAST(N'10:00:00' AS Time), CAST(N'19:00:00' AS Time))
INSERT [dbo].[DoctorSchedule] ([Id], [DoctorId], [Date], [StartTime], [EndTime]) VALUES (10, 2, CAST(N'2021-12-16' AS Date), CAST(N'10:00:00' AS Time), CAST(N'19:00:00' AS Time))
INSERT [dbo].[DoctorSchedule] ([Id], [DoctorId], [Date], [StartTime], [EndTime]) VALUES (11, 2, CAST(N'2021-12-19' AS Date), CAST(N'10:00:00' AS Time), CAST(N'19:00:00' AS Time))
INSERT [dbo].[DoctorSchedule] ([Id], [DoctorId], [Date], [StartTime], [EndTime]) VALUES (12, 3, CAST(N'2021-12-11' AS Date), CAST(N'08:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[DoctorSchedule] ([Id], [DoctorId], [Date], [StartTime], [EndTime]) VALUES (13, 3, CAST(N'2021-12-12' AS Date), CAST(N'10:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[DoctorSchedule] ([Id], [DoctorId], [Date], [StartTime], [EndTime]) VALUES (14, 3, CAST(N'2021-12-13' AS Date), CAST(N'12:00:00' AS Time), CAST(N'16:00:00' AS Time))
INSERT [dbo].[DoctorSchedule] ([Id], [DoctorId], [Date], [StartTime], [EndTime]) VALUES (15, 3, CAST(N'2021-12-14' AS Date), CAST(N'14:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[DoctorSchedule] ([Id], [DoctorId], [Date], [StartTime], [EndTime]) VALUES (16, 3, CAST(N'2021-12-15' AS Date), CAST(N'16:00:00' AS Time), CAST(N'20:00:00' AS Time))
INSERT [dbo].[DoctorSchedule] ([Id], [DoctorId], [Date], [StartTime], [EndTime]) VALUES (17, 4, CAST(N'2021-12-13' AS Date), CAST(N'10:00:00' AS Time), CAST(N'19:00:00' AS Time))
INSERT [dbo].[DoctorSchedule] ([Id], [DoctorId], [Date], [StartTime], [EndTime]) VALUES (18, 4, CAST(N'2021-12-16' AS Date), CAST(N'12:00:00' AS Time), CAST(N'21:00:00' AS Time))
INSERT [dbo].[DoctorSchedule] ([Id], [DoctorId], [Date], [StartTime], [EndTime]) VALUES (19, 5, CAST(N'2021-12-12' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time))
INSERT [dbo].[DoctorSchedule] ([Id], [DoctorId], [Date], [StartTime], [EndTime]) VALUES (20, 5, CAST(N'2021-12-15' AS Date), CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time))
INSERT [dbo].[DoctorSchedule] ([Id], [DoctorId], [Date], [StartTime], [EndTime]) VALUES (24, 1, CAST(N'2022-02-08' AS Date), CAST(N'09:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[DoctorSchedule] ([Id], [DoctorId], [Date], [StartTime], [EndTime]) VALUES (26, 1, CAST(N'2022-02-23' AS Date), CAST(N'08:30:00' AS Time), CAST(N'09:00:00' AS Time))
INSERT [dbo].[DoctorSchedule] ([Id], [DoctorId], [Date], [StartTime], [EndTime]) VALUES (28, 1, CAST(N'2022-02-07' AS Date), CAST(N'08:00:00' AS Time), CAST(N'10:00:00' AS Time))
INSERT [dbo].[DoctorSchedule] ([Id], [DoctorId], [Date], [StartTime], [EndTime]) VALUES (30, 1, CAST(N'2022-02-01' AS Date), CAST(N'08:30:00' AS Time), CAST(N'11:30:00' AS Time))
SET IDENTITY_INSERT [dbo].[DoctorSchedule] OFF
GO
INSERT [dbo].[Gender] ([Code], [Name]) VALUES (N'F', N'Female')
INSERT [dbo].[Gender] ([Code], [Name]) VALUES (N'M', N'Male')
GO
INSERT [dbo].[Role] ([Id], [Name]) VALUES (1, N'Administrator')
GO
SET IDENTITY_INSERT [dbo].[Specialization] ON 

INSERT [dbo].[Specialization] ([Id], [Name]) VALUES (1, N'Гастроэнтеролог')
INSERT [dbo].[Specialization] ([Id], [Name]) VALUES (2, N'Кардиолог')
INSERT [dbo].[Specialization] ([Id], [Name]) VALUES (3, N'Терапевт')
INSERT [dbo].[Specialization] ([Id], [Name]) VALUES (4, N'Стоматолог')
INSERT [dbo].[Specialization] ([Id], [Name]) VALUES (5, N'Офтальмолог')
SET IDENTITY_INSERT [dbo].[Specialization] OFF
GO
INSERT [dbo].[User] ([Id], [Login], [Password], [RoleId], [FirstName], [LastName], [Patronymic]) VALUES (1, N'Admin', N'Admin', 1, N'Roman', N'Ivanov', N'Ivanovich')
INSERT [dbo].[User] ([Id], [Login], [Password], [RoleId], [FirstName], [LastName], [Patronymic]) VALUES (2, N'Jack', N'Jack', 1, N'Jack', N'Jack', N'Jackovich')
INSERT [dbo].[User] ([Id], [Login], [Password], [RoleId], [FirstName], [LastName], [Patronymic]) VALUES (3, N'Nikolai', N'Nikolai', 1, N'Nikolai', N'Nikolai', N'Nikolaevich')
GO
ALTER TABLE [dbo].[Appointment]  WITH CHECK ADD  CONSTRAINT [FK_Appointment_Client] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Client] ([Id])
GO
ALTER TABLE [dbo].[Appointment] CHECK CONSTRAINT [FK_Appointment_Client]
GO
ALTER TABLE [dbo].[Appointment]  WITH CHECK ADD  CONSTRAINT [FK_Appointment_DoctorSchedule] FOREIGN KEY([DoctorScheduleId])
REFERENCES [dbo].[DoctorSchedule] ([Id])
GO
ALTER TABLE [dbo].[Appointment] CHECK CONSTRAINT [FK_Appointment_DoctorSchedule]
GO
ALTER TABLE [dbo].[Client]  WITH CHECK ADD  CONSTRAINT [FK_Client_Gender] FOREIGN KEY([GenderCode])
REFERENCES [dbo].[Gender] ([Code])
GO
ALTER TABLE [dbo].[Client] CHECK CONSTRAINT [FK_Client_Gender]
GO
ALTER TABLE [dbo].[Doctor]  WITH CHECK ADD  CONSTRAINT [FK_Doctor_Specialization] FOREIGN KEY([SpecializationId])
REFERENCES [dbo].[Specialization] ([Id])
GO
ALTER TABLE [dbo].[Doctor] CHECK CONSTRAINT [FK_Doctor_Specialization]
GO
ALTER TABLE [dbo].[DoctorSchedule]  WITH CHECK ADD  CONSTRAINT [FK_DoctorSchedule_Doctor] FOREIGN KEY([DoctorId])
REFERENCES [dbo].[Doctor] ([Id])
GO
ALTER TABLE [dbo].[DoctorSchedule] CHECK CONSTRAINT [FK_DoctorSchedule_Doctor]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([Id])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Appointment"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 221
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DoctorSchedule"
            Begin Extent = 
               Top = 6
               Left = 259
               Bottom = 136
               Right = 433
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Doctor"
            Begin Extent = 
               Top = 6
               Left = 471
               Bottom = 136
               Right = 645
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Client"
            Begin Extent = 
               Top = 6
               Left = 683
               Bottom = 136
               Right = 857
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DoctorScheduleView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DoctorScheduleView'
GO
