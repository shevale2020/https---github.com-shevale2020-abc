using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;


    public class TaskSummeryController : Controller
    {

        public ActionResult popupDetail(int locationId = 2, string taskType = "TodayOpenUnActioned")
        {
            ViewBag.TaskType = taskType;
            querys task = new querys();
            return View(task.SubReportDetail(taskType, locationId));
        }

        public ActionResult SummeryReport()
        {

            querys data = new querys();

            return View(data.SummaryReportOnDate(DateTime.Now));
        }

    }
