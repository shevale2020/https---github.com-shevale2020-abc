using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebApplication3.Controllers
{
    class TaskInfo
    {
        public  string title { get; set; }
        //value is used for calculate task number
        public int? value { get; set; }
        // task end date
        public string date { get; set; }
        //if any extra param to send
        public string extra { get; set; }

    }
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
       

            return View();
        }

        public JsonResult filterdata()
        {
            //Create sample data
            List<TaskInfo> _info = new List<TaskInfo>();
            _info.Add(
                new TaskInfo
                {
                    title = "Task 1",
                    value = null,
                    date = "21/03/2017",
                    extra = ""
                });
            _info.Add(
               new TaskInfo
               {
                   title = "Task 1",
                   value = null,
                   date = "22/04/2017",
                   extra = ""
               });
            _info.Add(
               new TaskInfo
               {
                   title = "Task 2",
                   value = null,
                   date = "22/04/2017",
                   extra = ""
               });
            _info.Add(
               new TaskInfo
               {
                   title = "Task 1",
                   value = null,
                   date = "24/06/2017",
                   extra = ""
               });

            // logic for add value of task date wise task number assign ..same date it will 1,2,3,4 etc
            int counter = 1;
            string oldValue = "";
            foreach (var item in _info.OrderBy(x => x.date))
            {
                if (oldValue != item.date)
                {
                    counter = 1;
                }
                else
                {
                    counter++;
                }
                oldValue = item.date;
                item.value = counter;
            }

            //here customise column name
            var output = from i in _info
                         select new
                         {
                             TaskTitle = i.title,
                             TaskNumber = i.value,
                             TaskDate = i.date,
                             extra = i.extra
                         };

          


            return Json( JsonConvert.SerializeObject(output) , JsonRequestBehavior.AllowGet);



        }

    }

    
    
}
