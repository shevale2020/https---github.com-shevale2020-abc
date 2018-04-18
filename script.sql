USE [eClose_Testing]
GO
/****** Object:  Table [dbo].[DependetWorkbasketTasks]    Script Date: 4/18/2018 5:23:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DependetWorkbasketTasks](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[WorkbasketTaskId] [int] NOT NULL,
	[DependsOnWorkbasketTaskId] [int] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeletedBy] [varchar](50) NULL,
	[DeletedOn] [datetime] NULL,
	[CanStart] [bit] NOT NULL,
	[UpdatedBy] [varchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[TenantId] [int] NOT NULL,
 CONSTRAINT [PK_DependetWorkbasketTasks] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Location]    Script Date: 4/18/2018 5:23:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Location](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LocationName] [nvarchar](100) NOT NULL,
	[TimeZone] [varchar](50) NOT NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[TenantId] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeletedBy] [nvarchar](50) NULL,
	[DeletedOn] [datetime] NULL,
 CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Period]    Script Date: 4/18/2018 5:23:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Period](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PeriodMonth] [smallint] NULL,
	[PeriodYear] [int] NULL,
	[TenantId] [int] NOT NULL,
	[LocationId] [int] NULL,
	[NegativeDays] [smallint] NULL,
	[PositiveDays] [smallint] NULL,
	[FirstWorkday] [date] NULL,
	[IsClosed] [bit] NOT NULL,
	[RecCreatedBy] [varchar](50) NULL,
	[RecCretedDate] [datetime] NULL,
	[RecUpdatedBy] [varchar](50) NULL,
	[RecUpdatedDate] [datetime] NULL,
	[PeriodText] [varchar](50) NULL,
	[IsFreeze] [bit] NOT NULL,
 CONSTRAINT [PK_Period] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PeriodDays]    Script Date: 4/18/2018 5:23:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PeriodDays](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PeriodId] [int] NULL,
	[CalenderDate] [date] NULL,
	[WorkDay] [int] NULL,
	[IsOff] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[RecCreatedBy] [varchar](50) NULL,
	[RecCretedDate] [date] NULL,
	[RecUpdatedBy] [varchar](50) NULL,
	[RecUpdatedDate] [date] NULL,
	[TenantId] [int] NULL,
 CONSTRAINT [PK_PeriodDays] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Task]    Script Date: 4/18/2018 5:23:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Task](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TaskNumber] [nvarchar](50) NULL,
	[TaskName] [nvarchar](500) NOT NULL,
	[TeamId] [int] NOT NULL,
	[Frequency] [varchar](50) NOT NULL,
	[WorkflowId] [int] NULL,
	[IsAdhoc] [bit] NOT NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [nvarchar](50) NULL,
	[IsDeleted] [bit] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[DeletedBy] [nvarchar](50) NULL,
	[DeletedOn] [datetime] NULL,
	[TenantId] [int] NOT NULL,
	[Priority] [varchar](50) NULL,
	[Description] [nvarchar](500) NULL,
	[PriorityId] [smallint] NOT NULL,
 CONSTRAINT [PK_Task] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Team]    Script Date: 4/18/2018 5:23:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Team](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TeamName] [nvarchar](100) NOT NULL,
	[LocationId] [int] NOT NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[TenantId] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeletedBy] [nvarchar](50) NULL,
	[DeletedOn] [datetime] NULL,
 CONSTRAINT [PK_Team] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WorkbasketTask]    Script Date: 4/18/2018 5:23:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WorkbasketTask](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TaskId] [int] NULL,
	[PeriodId] [int] NULL,
	[WorkflowId] [int] NULL,
	[StatusId] [int] NULL,
	[DocPath] [nvarchar](1000) NULL,
	[Attempt] [int] NOT NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[DeletedOn] [datetime] NULL,
	[DeletedBy] [nvarchar](50) NULL,
	[TenantId] [int] NOT NULL,
	[TimeZone] [varchar](50) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TeamId] [int] NOT NULL,
	[Frequency] [varchar](50) NULL,
	[TaskName] [nvarchar](500) NOT NULL,
	[Priority] [varchar](50) NULL,
	[Description] [nvarchar](500) NULL,
	[IsForcedClose] [bit] NOT NULL,
	[PriorityId] [smallint] NOT NULL,
 CONSTRAINT [PK_WorkbasketTask] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[WorkbasketTaskUsers]    Script Date: 4/18/2018 5:23:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WorkbasketTaskUsers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TenantId] [int] NOT NULL,
	[WorkbasketTaskId] [int] NOT NULL,
	[WFLevel] [smallint] NOT NULL,
	[UserId] [int] NULL,
	[EndDateInt] [datetime] NULL,
	[ActualEndDate] [datetime] NULL,
	[IntimationDateInt] [datetime] NULL,
	[RAGStatusInt] [varchar](5) NULL,
	[EndDateExt] [datetime] NULL,
	[IntimationDateExt] [datetime] NULL,
	[RAGStatusExt] [varchar](5) NULL,
	[IntEndDay] [smallint] NULL,
	[IntEndTime] [varchar](8) NULL,
	[ExtEndDay] [smallint] NULL,
	[ExtEndTime] [varchar](8) NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedBy] [varchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeletedBy] [varchar](50) NULL,
	[DeletedOn] [datetime] NULL,
	[IsForcedClose] [bit] NOT NULL,
 CONSTRAINT [PK_ActivityTransUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[DependetWorkbasketTasks] ADD  CONSTRAINT [DF_DependetWorkbasketTasks_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[DependetWorkbasketTasks] ADD  CONSTRAINT [DF_DependetWorkbasketTasks_CanStart]  DEFAULT ((0)) FOR [CanStart]
GO
ALTER TABLE [dbo].[Location] ADD  CONSTRAINT [DF_Location_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Period] ADD  CONSTRAINT [DF_Period_IsClosed]  DEFAULT ((0)) FOR [IsClosed]
GO
ALTER TABLE [dbo].[Period] ADD  CONSTRAINT [DF_Period_IsFreeze]  DEFAULT ((0)) FOR [IsFreeze]
GO
ALTER TABLE [dbo].[PeriodDays] ADD  CONSTRAINT [DF_PeriodDays_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Task] ADD  CONSTRAINT [DF_Task_IsAdhoc]  DEFAULT ((0)) FOR [IsAdhoc]
GO
ALTER TABLE [dbo].[Task] ADD  CONSTRAINT [DF_Task_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Task] ADD  CONSTRAINT [DF_Task_IsActive]  DEFAULT ((0)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Team] ADD  CONSTRAINT [DF_Team_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[WorkbasketTask] ADD  CONSTRAINT [DF_WorkbasketTask_TaskId]  DEFAULT (NULL) FOR [TaskId]
GO
ALTER TABLE [dbo].[WorkbasketTask] ADD  CONSTRAINT [DF_WorkbasketTask_Attempt]  DEFAULT ((1)) FOR [Attempt]
GO
ALTER TABLE [dbo].[WorkbasketTask] ADD  CONSTRAINT [DF_WorkbasketTask_IsDeleted_1]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[WorkbasketTask] ADD  CONSTRAINT [DF_WorkbasketTask_IsForcedClose]  DEFAULT ((0)) FOR [IsForcedClose]
GO
ALTER TABLE [dbo].[WorkbasketTaskUsers] ADD  CONSTRAINT [DF_WorkbasketTaskUsers_RAGStatusInt]  DEFAULT ('G') FOR [RAGStatusInt]
GO
ALTER TABLE [dbo].[WorkbasketTaskUsers] ADD  CONSTRAINT [DF_WorkbasketTaskUsers_RAGStatusExt]  DEFAULT ('G') FOR [RAGStatusExt]
GO
ALTER TABLE [dbo].[WorkbasketTaskUsers] ADD  CONSTRAINT [DF_WorkbasketTaskUsers_IsForcedClose]  DEFAULT ((0)) FOR [IsForcedClose]
GO
ALTER TABLE [dbo].[DependetWorkbasketTasks]  WITH CHECK ADD  CONSTRAINT [FK_DependetWorkbasketTasks_DependsOnWbTask] FOREIGN KEY([DependsOnWorkbasketTaskId])
REFERENCES [dbo].[WorkbasketTask] ([Id])
GO
ALTER TABLE [dbo].[DependetWorkbasketTasks] CHECK CONSTRAINT [FK_DependetWorkbasketTasks_DependsOnWbTask]
GO
ALTER TABLE [dbo].[DependetWorkbasketTasks]  WITH CHECK ADD  CONSTRAINT [FK_DependetWorkbasketTasks_WorkbasketTask] FOREIGN KEY([WorkbasketTaskId])
REFERENCES [dbo].[WorkbasketTask] ([Id])
GO
ALTER TABLE [dbo].[DependetWorkbasketTasks] CHECK CONSTRAINT [FK_DependetWorkbasketTasks_WorkbasketTask]
GO
ALTER TABLE [dbo].[Location]  WITH CHECK ADD  CONSTRAINT [FK_Location_BusinessUnit] FOREIGN KEY([TenantId])
REFERENCES [dbo].[Tenant] ([Id])
GO
ALTER TABLE [dbo].[Location] CHECK CONSTRAINT [FK_Location_BusinessUnit]
GO
ALTER TABLE [dbo].[Period]  WITH CHECK ADD  CONSTRAINT [FK_Period_BusinessUnit] FOREIGN KEY([TenantId])
REFERENCES [dbo].[Tenant] ([Id])
GO
ALTER TABLE [dbo].[Period] CHECK CONSTRAINT [FK_Period_BusinessUnit]
GO
ALTER TABLE [dbo].[Period]  WITH CHECK ADD  CONSTRAINT [FK_Period_Location] FOREIGN KEY([LocationId])
REFERENCES [dbo].[Location] ([Id])
GO
ALTER TABLE [dbo].[Period] CHECK CONSTRAINT [FK_Period_Location]
GO
ALTER TABLE [dbo].[PeriodDays]  WITH CHECK ADD  CONSTRAINT [FK_PeriodDays_Period] FOREIGN KEY([PeriodId])
REFERENCES [dbo].[Period] ([Id])
GO
ALTER TABLE [dbo].[PeriodDays] CHECK CONSTRAINT [FK_PeriodDays_Period]
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Task_BusinessUnit] FOREIGN KEY([TenantId])
REFERENCES [dbo].[Tenant] ([Id])
GO
ALTER TABLE [dbo].[Task] CHECK CONSTRAINT [FK_Task_BusinessUnit]
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Task_Priority] FOREIGN KEY([PriorityId])
REFERENCES [dbo].[Priorities] ([Id])
GO
ALTER TABLE [dbo].[Task] CHECK CONSTRAINT [FK_Task_Priority]
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Task_Team] FOREIGN KEY([TeamId])
REFERENCES [dbo].[Team] ([Id])
GO
ALTER TABLE [dbo].[Task] CHECK CONSTRAINT [FK_Task_Team]
GO
ALTER TABLE [dbo].[Team]  WITH CHECK ADD  CONSTRAINT [FK_Team_BusinessUnit] FOREIGN KEY([TenantId])
REFERENCES [dbo].[Tenant] ([Id])
GO
ALTER TABLE [dbo].[Team] CHECK CONSTRAINT [FK_Team_BusinessUnit]
GO
ALTER TABLE [dbo].[Team]  WITH CHECK ADD  CONSTRAINT [FK_Team_Location] FOREIGN KEY([LocationId])
REFERENCES [dbo].[Location] ([Id])
GO
ALTER TABLE [dbo].[Team] CHECK CONSTRAINT [FK_Team_Location]
GO
ALTER TABLE [dbo].[WorkbasketTask]  WITH CHECK ADD  CONSTRAINT [FK_WorkbasketTask_Period] FOREIGN KEY([PeriodId])
REFERENCES [dbo].[Period] ([Id])
GO
ALTER TABLE [dbo].[WorkbasketTask] CHECK CONSTRAINT [FK_WorkbasketTask_Period]
GO
ALTER TABLE [dbo].[WorkbasketTask]  WITH CHECK ADD  CONSTRAINT [FK_WorkbasketTask_Priority] FOREIGN KEY([PriorityId])
REFERENCES [dbo].[Priorities] ([Id])
GO
ALTER TABLE [dbo].[WorkbasketTask] CHECK CONSTRAINT [FK_WorkbasketTask_Priority]
GO
ALTER TABLE [dbo].[WorkbasketTask]  WITH CHECK ADD  CONSTRAINT [FK_WorkbasketTask_Task] FOREIGN KEY([TaskId])
REFERENCES [dbo].[Task] ([Id])
GO
ALTER TABLE [dbo].[WorkbasketTask] CHECK CONSTRAINT [FK_WorkbasketTask_Task]
GO
ALTER TABLE [dbo].[WorkbasketTask]  WITH CHECK ADD  CONSTRAINT [FK_WorkbasketTask_Team] FOREIGN KEY([TeamId])
REFERENCES [dbo].[Team] ([Id])
GO
ALTER TABLE [dbo].[WorkbasketTask] CHECK CONSTRAINT [FK_WorkbasketTask_Team]
GO
ALTER TABLE [dbo].[WorkbasketTask]  WITH CHECK ADD  CONSTRAINT [FK_WorkbasketTask_Tenant] FOREIGN KEY([TenantId])
REFERENCES [dbo].[Tenant] ([Id])
GO
ALTER TABLE [dbo].[WorkbasketTask] CHECK CONSTRAINT [FK_WorkbasketTask_Tenant]
GO
ALTER TABLE [dbo].[WorkbasketTask]  WITH CHECK ADD  CONSTRAINT [FK_WorkbasketTask_WorkflowActions] FOREIGN KEY([StatusId])
REFERENCES [dbo].[WorkflowActions] ([Id])
GO
ALTER TABLE [dbo].[WorkbasketTask] CHECK CONSTRAINT [FK_WorkbasketTask_WorkflowActions]
GO
ALTER TABLE [dbo].[WorkbasketTask]  WITH CHECK ADD  CONSTRAINT [FK_WorkbasketTask_Workflows] FOREIGN KEY([WorkflowId])
REFERENCES [dbo].[Workflows] ([Id])
GO
ALTER TABLE [dbo].[WorkbasketTask] CHECK CONSTRAINT [FK_WorkbasketTask_Workflows]
GO
ALTER TABLE [dbo].[WorkbasketTaskUsers]  WITH CHECK ADD  CONSTRAINT [FK_WorkbasketTaskUsers_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[WorkbasketTaskUsers] CHECK CONSTRAINT [FK_WorkbasketTaskUsers_User]
GO
ALTER TABLE [dbo].[WorkbasketTaskUsers]  WITH CHECK ADD  CONSTRAINT [FK_WorkbasketTaskUsers_WorkbasketTask] FOREIGN KEY([WorkbasketTaskId])
REFERENCES [dbo].[WorkbasketTask] ([Id])
GO
ALTER TABLE [dbo].[WorkbasketTaskUsers] CHECK CONSTRAINT [FK_WorkbasketTaskUsers_WorkbasketTask]
GO
