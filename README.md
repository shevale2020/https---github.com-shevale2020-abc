using ECloseWebApp.BuisnessEntities;
using ECloseWebApp.HelperClasses;
using ECloseWebApp.Models;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web.Mvc;
using ECloseWebAPI.Models;
using System.Threading.Tasks;
using Newtonsoft.Json.Linq;
using System.Linq;

namespace ECloseWebApp.Controllers
{
    [HandleExceptionsAttribute]
    class TeamTask
    {
        public int Id { get; set; }
        public int PeriodId { get; set; }
        public int LocationId { get; set; }
        public int TeamId { get; set; }
        public string TeamName { get; set; }
        public string TaskName { get; set; }
        public int TaskId { get; set; }
        public int DependantTaskId { get; set; }
        public int Day { get; set; }
        public DateTime EndDate { get; set; }
    }
    public class ReportController : Controller
    {


        log4net.ILog logger = log4net.LogManager.GetLogger(typeof(LoginController));  //Declaring Log4Net 
        // GET: Report
        public ActionResult Index()
        {


            ViewBag.Report = Request.QueryString["report"].ToString();
            int locationId=0;
            var vm = new ViewModelForBusinessUnitDD();
            using (var httpClient = new HttpClient())
            {
                             

                int tenantId = SessionWrapper.TenantId;
                httpClient.BaseAddress = new Uri(Constants.ApiPath);
                httpClient.DefaultRequestHeaders.Clear();
                httpClient.DefaultRequestHeaders.AcceptLanguage.Add(new StringWithQualityHeaderValue("nl-NL"));

                httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                var responseLocation = httpClient.GetAsync(string.Format("Location/GetBusinessUnitLocations?TenantId={0}", tenantId)).Result;
                var resultLocation = responseLocation.Content.ReadAsStringAsync().Result;
                var locations = JsonConvert.DeserializeObject<List<Location>>(resultLocation);

                foreach (var location in locations)
                {
                    vm.Location.Add(new SelectListItem { Text = location.LocationName, Value = location.Id.ToString() });
                }

                if (vm.Location.Count > 0 && vm.Location[0].Value != null)
                {
                    locationId = Convert.ToInt32(vm.Location[0].Value);
                }

                var responseTeam = httpClient.GetAsync(string.Format("Team/LocationTeamList?LocationId={0}", locationId)).Result;
                var resultTeams = responseTeam.Content.ReadAsStringAsync().Result;
                var teams = JsonConvert.DeserializeObject<List<ECloseBL.Entities.Team>>(resultTeams);

                foreach (var team in teams)
                {
                    vm.Team.Add(new SelectListItem { Text = team.TeamName, Value = team.Id.ToString() });
                }

                vm.Team.Insert(0, new SelectListItem { Text = "--All--", Value = "0"});
               


            }
            return View(vm);
        }





        //        [HttpPost]
        //        public async Task<JsonResult> GetTaskTimelineChartReport(int LocationId, int PeriodId)
        //        {
        //            using (var httpClient = new HttpClient())
        //            {

        //                string json = @"{  
        //   'directed':false,
        //   'graph':[
        //      [
        //         'node_default',
        //         {  

        //         }
        //      ],
        //      [
        //         'name',
        //         '()_with_int_tasks'
        //      ],
        //      [
        //         'edge_default',
        //         {  

        //         }
        //      ]
        //   ],
        //   'nodes':[
        //      {  
        //         'id':0,
        //         'Day':1,
        //         'Team':'TEAM2',
        //         'cDay':1,
        //         'task':'The randomized complexity of maintaining the minimum'
        //      },
        //      {  
        //         'id':1,
        //         'Day':2,
        //         'Team':'TEAM2',
        //         'cDay':2,
        //         'task':'Probabilistic data structures for priority queues'
        //      },
        //      {  
        //         'id':2,
        //         'Day':3,
        //         'Team':'TEAM2',
        //         'cDay':3,
        //         'task':'Fractional cascading simplified'
        //      },
        //      {  
        //         'id':3,
        //         'Day':4,
        //         'Team':'TEAM2',
        //         'cDay':4,
        //         'task':'Paging on a RAM with Limited Resources'
        //      },
        //      {  
        //         'id':4,
        //         'Day':5,
        //         'Team':'TEAM1',
        //         'cDay':5,
        //         'task':'Online Data Structures in External Memory'
        //      },
        //      {  
        //         'id':5,
        //         'Day':6,
        //         'Team':'TEAM2',
        //         'cDay':6,
        //         'task':'Binary search trees: How low can you go?'
        //      },
        //      {  
        //         'id':6,
        //         'Day':7,
        //         'Team':'TEAM2',
        //         'cDay':29,
        //         'task':'Randomized geometric algorithms (abstract)'
        //      },
        //      {  
        //         'id':7,
        //         'Day':8,
        //         'Team':'TEAM1',
        //         'cDay':9,
        //         'task':'Improving partial rebuilding by using simple balance criteria'
        //      },
        //      {  
        //         'id':8,
        //         'Day':7,
        //         'Team':'TEAM2',
        //         'cDay':8,
        //         'task':'Parallel dynamic lowest common ancestors'
        //      },
        //      {  
        //         'id':9,
        //         'Day':10,
        //         'Team':'TEAM1',
        //         'cDay':10,
        //         'task':'Space Efficient Data Structures for Dynamic Orthogonal Range Counting'
        //      },
        //      {  
        //         'id':10,
        //         'Day':11,
        //         'Team':'TEAM2',
        //         'cDay':11,
        //         'task':'Cache-Oblivious Algorithms and Data Structures'
        //      },
        //      {  
        //         'id':11,
        //         'Day':7,
        //         'Team':'TEAM2',
        //         'cDay':8,
        //         'task':'The parallel hierarchical memory model'
        //      },
        //      {  
        //         'id':12,
        //         'Day':12,
        //         'Team':'TEAM1',
        //         'cDay':12,
        //         'task':'Time Responsive External Data Structures for Moving Points'
        //      },
        //      {  
        //         'id':13,
        //         'Day':5,
        //         'Team':'TEAM1',
        //         'cDay':6,
        //         'task':'Orthogonal Range Searching in Linear and Almost-Linear Space'
        //      },
        //      {  
        //         'id':14,
        //         'Day':3,
        //         'Team':'TEAM2',
        //         'cDay':4,
        //         'task':'Confluently Persistent Tries for Efficient Version Control'
        //      },
        //      {  
        //         'id':15,
        //         'Day':10,
        //         'Team':'TEAM1',
        //         'cDay':11,
        //         'task':'Blame Trees'
        //      },
        //      {  
        //         'id':16,
        //         'Day':2,
        //         'Team':'TEAM2',
        //         'cDay':3,
        //         'task':'Lower bounds for dynamic transitive closure, planar point location, and parentheses matching'
        //      },
        //      {  
        //         'id':17,
        //         'Day':8,
        //         'Team':'TEAM2',
        //         'cDay':20,
        //         'task':'Lower bounds for dynamic algorithms'
        //      },
        //      {  
        //         'id':18,
        //         'Day':9,
        //         'Team':'TEAM1',
        //         'cDay':9,
        //         'task':'Rank-Balanced Trees'
        //      },
        //    {
        //      'id': 19,
        //      'Day': 10,
        //      'Team': 'TEAM1',
        //      'cDay': 11,
        //      'task': 'Approximation Algorithm for Hotlink Assignments in Web Directories'
        //    },

        //      {  
        //         'id':20,
        //         'Day':11,
        //         'Team':'TEAM1',
        //         'cDay':12,
        //         'task':'Approximation Algorithm for Hotlink Assignments in Web Directories'
        //      }
        //   ],
        //   'links':[
        //      {  
        //         'Edge Id':'12640',
        //         'target':19,
        //         'source':0,
        //         'Day':11
        //      },
        //      {  
        //         'Edge Id':'12714',
        //         'target':9,
        //         'source':0,
        //         'Day':10
        //      },
        //      {  
        //         'Edge Id':'12715',
        //         'target':5,
        //         'source':0,
        //         'Day':6
        //      },
        //      {  
        //         'Edge Id':'12534',
        //         'target':7,
        //         'source':1,
        //         'Day':29
        //      },
        //      {  
        //         'Edge Id':'12535',
        //         'target':7,
        //         'source':11,
        //         'Day':29
        //      },
        //      {  
        //         'Edge Id':'12549',
        //         'target':12,
        //         'source':2,
        //         'Day':12
        //      },
        //      {  
        //         'Edge Id':'12498',
        //         'target':3,
        //         'source':13,
        //         'Day':6
        //      },
        //      {  
        //         'Edge Id':'12596',
        //         'target':8,
        //         'source':4,
        //         'Day':20
        //      },
        //      {  
        //         'Edge Id':'12595',
        //         'target':3,
        //         'source':4,
        //         'Day':5
        //      },
        //      {  
        //         'Edge Id':'12728',
        //         'target':2,
        //         'source':14,
        //         'Day':4
        //      },
        //      {  
        //         'Edge Id':'12597',
        //         'target':7,
        //         'source':4,
        //         'Day':29
        //      },
        //      {  
        //         'Edge Id':'12691',
        //         'target':8,
        //         'source':5,
        //         'Day':20
        //      },
        //      {  
        //         'Edge Id':'12690',
        //         'target':2,
        //         'source':5,
        //         'Day':6
        //      },
        //      {  
        //         'Edge Id':'12666',
        //         'target':7,
        //         'source':6,
        //         'Day':29
        //      },
        //      {  
        //         'Edge Id':'12664',
        //         'target':8,
        //         'source':7,
        //         'Day':29
        //      },
        //      {  
        //         'Edge Id':'12712',
        //         'target':8,
        //         'source':9,
        //         'Day':20
        //      },
        //      {  
        //         'Edge Id':'12446',
        //         'target':3,
        //         'source':9,
        //         'Day':10
        //      },
        //      {  
        //         'Edge Id':'12447',
        //         'target':1,
        //         'source':9,
        //         'Day':10
        //      },
        //      {  
        //         'Edge Id':'12448',
        //         'target':13,
        //         'source':20,
        //         'Day':12
        //      }
        //   ],
        //   'multigraph':false
        //}";

        //                JObject data = JObject.Parse(json);

        //                ViewBag.mapData = data;

        //                Period entity = new Period();
        //                entity.Id = PeriodId;
        //                entity.LocationId = LocationId;
        //                var servicePath = Constants.ApiPath + "api/Report/GetTaskTimelineChartReport";

        //                HttpResponseMessage responseMessage = await httpClient.PostAsJsonAsync(servicePath, entity);
        //                var responseData = responseMessage.Content.ReadAsStringAsync().Result;
        //                var task = JsonConvert.DeserializeObject(responseData);
        //                if (Convert.ToInt32(task) == 0)
        //                {
        //                    return Json(new { Result = "SUCCESS", Message = Constants.TaskIsExists });
        //                }
        //                else
        //                {

        //                    return Json(new { Result = "OK", Message = "Record Added.", Record = entity });
        //                }

        //            }

        //            return Json(new { Result = "ERROR", Message = Constants.ErrorSessionExpired });
        //        }

        //get chart data
        [HttpGet]
        public async Task<JsonResult> GetReportData(int LocationId, int PeriodId)
        {
            //create sample data .
            try
            {
                var path = Constants.ApiPath + "api/Report/GetTaskTimelineChartReport? LocationId=" + LocationId + "&PeriodId=" + PeriodId;
                using (var httpClient = new HttpClient())
                {
                    HttpResponseMessage response = httpClient.GetAsync(path).Result;
                    var responseData = response.Content.ReadAsStringAsync().Result;
                    var task = JsonConvert.DeserializeObject(responseData);
                    if (task != null)
                    {
                        List<TeamTask> taskDetails = new List<TeamTask>();
                       
                        //taskDetails.Add(new TeamTask
                        //{
                        //    PeriodId = 83,
                        //    LocationId = 183,
                        //    TeamId = 391,
                        //    TeamName = "Demo1",
                        //    TaskName = "Bank Group",
                        //    TaskId = 1387,
                        //    DependantTaskId = 1387,
                        //    Day = 4,
                        //    EndDate = new DateTime(2017, 09, 04),

                        //});

                        //taskDetails.Add(
                        //    new TeamTask
                        //    {
                        //        PeriodId = 83,
                        //        LocationId = 185,
                        //        TeamId = 391,
                        //        TeamName = "Demo2",
                        //        TaskName = "Bank Group",
                        //        TaskId = 1388,
                        //        DependantTaskId = 1389,
                        //        Day = 22,
                        //        EndDate = new DateTime(2017, 9, 22)
                        //    });
                        //taskDetails.Add(new TeamTask
                        //{
                        //    PeriodId = 83,
                        //    LocationId = 185,
                        //    TeamId = 391,
                        //    TeamName = "Demo3",
                        //    TaskName = "Close group",
                        //    TaskId = 1389,
                        //    DependantTaskId = 1389,
                        //    Day = 5,
                        //    EndDate = new DateTime(2017, 9, 05)
                        //});
                        //taskDetails.Add(new TeamTask
                        //{
                        //    PeriodId = 83,
                        //    LocationId = 183,
                        //    TeamId = 391,
                        //    TeamName = "Demo1",
                        //    TaskName = "Close group",
                        //    TaskId = 1394,
                        //    DependantTaskId = 1395,
                        //    Day = 22,
                        //    EndDate = new DateTime(2017, 9, 22)
                        //});
                        //taskDetails.Add(new TeamTask
                        //{
                        //    PeriodId = 83,
                        //    LocationId = 183,
                        //    TeamId = 391,
                        //    TeamName = "Demo3",
                        //    TaskName = "Close meets",
                        //    TaskId = 1395,
                        //    DependantTaskId = 1396,
                        //    Day = 22,
                        //    EndDate = new DateTime(2017, 9, 14)
                        //});
                        //taskDetails.Add(new TeamTask
                        //{
                        //    PeriodId = 183,
                        //    LocationId = 186,
                        //    TeamId = 391,
                        //    TeamName = "Demo2",
                        //    TaskName = "Close meets",
                        //    TaskId = 1396,
                        //    DependantTaskId = 1396,
                        //    Day = 22,
                        //    EndDate = new DateTime(2017, 9, 22)
                        //});

                        //filter data
                        var filterData = taskDetails.Where(x => x.LocationId == (LocationId == 0 ? x.LocationId : LocationId) && x.PeriodId == (PeriodId == 0 ? x.PeriodId : PeriodId)).ToList();

                        //create data for team color and value.
                        int count = 0;
                        var color = (filterData
                                                    .GroupBy(u => u.TeamName)
                                                    .Select(TeamName => new
                                                    {
                                                        value = count++,
                                                        name = TeamName.Key
                                                    })
                                                      .ToList());

                        //create node format data
                        var node = filterData
                                                 .Select(a => new
                                                 {
                                                     id = a.TaskId,
                                                     Day = a.Day,
                                                     Team = a.TeamName,
                                                     cDay = a.Day,
                                                     Task = "Task Name:" + a.TaskName + ", Due Date:" + a.EndDate.ToShortDateString(),
                                                     color = color.Where(x => x.name == a.TeamName).First().value
                                                 });

                        //create link date

                        var dependancy = filterData
                                                        .Select(a => new
                                                        {
                                                            EdgeId = a.TaskId.ToString(),
                                                            target = filterData.IndexOf(filterData.Find(x => x.TaskId == a.TaskId)),
                                                            source = filterData.IndexOf(filterData.Find(x => x.TaskId == a.DependantTaskId)),
                                                            cDay = a.Day
                                                        });
                        //create json format data
                        string _json = "";
                        _json = "{\"directed\": false,\"graph\": [[\"node_default\",{}],[\"name\",\"()_with_int_labels\"],[\"edge_default\",{}]],";
                        _json += "\"nodes\":" + JsonConvert.SerializeObject(node) + ",";
                        _json += "\"links\":" + JsonConvert.SerializeObject(dependancy) + ",";
                        _json += "\"multigraph\": false,";
                        _json += "\"colordata\": " + JsonConvert.SerializeObject(color);
                        _json += "}";


                        return Json(_json, JsonRequestBehavior.AllowGet);
                    }
                    else
                    {

                        return Json(new { Result = "OK", Message = "Record Not Found.", Record = task });
                    }
                }
            }
            catch (Exception ex)
            {
                logger.Error(ex.ToString());
                return Json(new { Result = "ERROR", Message = ex.Message });
            }

            //using (var httpClient = new HttpClient())
            //{
            //    Period entity = new Period();
            //    entity.Id = Convert.ToInt32(PeriodId);
            //    entity.LocationId = Convert.ToInt32(LocationId);
            //    var servicePath = Constants.ApiPath + "api/Report/GetTaskTimelineChartReport";

            //    HttpResponseMessage responseMessage = await httpClient.GetAsync(servicePath);
            //    var responseData = responseMessage.Content.ReadAsStringAsync().Result;
            //    var task = JsonConvert.DeserializeObject(responseData);
            //    if (Convert.ToInt32(task) == 0)
            //    {
            //        return Json(new { Result = "SUCCESS", Message = Constants.TaskIsExists });
            //    }
            //    else
            //    {

            //        return Json(new { Result = "OK", Message = "Record Added.", Record = entity });
            //    }
            //};
            //return Json(new { Result = "ERROR", Message = Constants.ErrorSessionExpired });
                        

           

        }
        public ActionResult GetTaskTimelineChartReport()
        {
                     
            return View();
        }
    }
}
