using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebApplication4.Controllers
{
    public class TaskSummeryController : Controller
    {

        public ActionResult popupDetail(int locationId , string taskType, DateTime inputDate)
        {
            ViewBag.TaskType = taskType;
            querys task = new querys();
            var subtaskDetail = task.SubReportDetail(taskType, locationId, inputDate);
            return View(subtaskDetail);
        }

        public ActionResult SummeryReport()
        {

            querys data = new querys();

            return View(data.SummaryReportOnDate(DateTime.Now));
        }

    }
}
