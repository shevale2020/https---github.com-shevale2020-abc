using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApplication4
{
    public class SummaryInfo
    {

        public int? LocationId { get; set; }
        public int PastClosedWithinTAT { get; set; }
        public int PastClosedTATMissed { get; set; }
        public int PastOpenOnHold { get; set; }
        public int PastOpenWIP { get; set; }
        public int PastOpenUnActioned { get; set; }
        public int TodayClosedWithinTAT { get; set; }
        public int TodayOpenOnHold { get; set; }
        public int TodayOpenWIP { get; set; }
        public int TodayOpenUnActioned { get; set; }
        public int FutureClosedBeforeTAT { get; set; }
        public int FutureOpenOnHold { get; set; }
        public int FutureOpenWIP { get; set; }
        public int FutureOpenUnActioned { get; set; }
        public int PastTotal { get; set; }
        public int TodayTotal { get; set; }
        public int FutureTotal { get; set; }
        public int Total { get; set; } 
}
    public class SubTaskDetail
    {
        
        public int? LocationId { get; set; }
        public string TaskName { get; set; }
        public string Status { get; set; }
        public bool? IsAction { get; set; }
        public DateTime? EndDateInt { get; set; }
        public DateTime? ActualEndDate { get; set; }
    }

    public class querys
    {
        public void queryResult()
        {
            DateTime inputDate = new DateTime();
            WebApplication4.eClose_DevEntities context = new WebApplication4.eClose_DevEntities();
            try
            {

           
            var output = from result in (
                                            (from wbusr in context.WorkbasketTaskUsers
                                             join wfl in context.WorkflowLevels
                                                   on new { WorkflowId = (int)(wbusr.WorkbasketTask.WorkflowId), Level = wbusr.WorkbasketTask.WorkflowAction.WorkflowLevel }
                                               equals new { wfl.WorkflowId, wfl.Level }
                                             group new { wbusr.WorkbasketTask.Period, wbusr.WorkbasketTask.WorkflowAction, wbusr } by new
                                             {
                                                 LocationId = (int?)wbusr.WorkbasketTask.Period.LocationId,
                                                 wbusr.WorkbasketTask.WorkflowAction.Status,
                                                 IsAction = (bool?)wbusr.WorkbasketTask.WorkflowAction.IsAction
                                             } into g
                                             select new
                                             {
                                                 LocationId = (int?)g.Key.LocationId,
                                                 g.Key.Status,
                                                 EndDateInt = (DateTime?)g.Max(p => p.wbusr.EndDateInt),
                                                 ActualEndDate = (DateTime?)g.Max(p => p.wbusr.ActualEndDate),
                                                 IsAction = (bool?)g.Key.IsAction
                                             }))
                         group result by new
                         {
                             result.LocationId
                         } into g
                         select new
                         {
                             g.Key.LocationId,
                             Closed_With_in_TAT = g.Sum(p => (
                             p.EndDateInt < inputDate &&
                             p.ActualEndDate <= p.EndDateInt ? 1 : 0)),
                             Closed_TAT_Missed = g.Sum(p => (
                             p.EndDateInt < inputDate &&
                             p.ActualEndDate > p.EndDateInt ? 1 : 0)),
                             Open_On_Hold = g.Sum(p => (
                             p.EndDateInt < inputDate &&
                             p.ActualEndDate > p.EndDateInt &&
                             (p.Status == "Inputs Awaited" ||
                             p.Status == "System Issue" ||
                             p.Status == "Queried to Sivantos") ? 1 : 0)),
                             Open_WIP = g.Sum(p => (
                             p.EndDateInt < inputDate &&
                             p.ActualEndDate > p.EndDateInt &&
                             (p.Status == "WIP" ||
                             p.Status == "Sent to Review" ||
                             p.Status == "Approved" ||
                             p.Status == "Rejected") ? 1 : 0)),
                             Open_Un_Actioned = g.Sum(p => (
                               p.EndDateInt < inputDate &&
                               p.Status == "Pending" &&
                               p.IsAction == false ? 1 : 0)),
                             Column1 = g.Sum(p => (
                             p.EndDateInt == inputDate &&
                             p.ActualEndDate == p.EndDateInt ? 1 : 0)),
                             Column2 = g.Sum(p => (
                             p.EndDateInt == inputDate &&
                             p.Status == "Hold" ? 1 : 0)),
                             Column3 = g.Sum(p => (
                             p.EndDateInt == inputDate &&
                             (p.Status == "WIP" ||
                             p.Status == "Sent to Review" ||
                             p.Status == "Approved" ||
                             p.Status == "Rejected") ? 1 : 0)),
                             Column4 = g.Sum(p => (
                             p.EndDateInt == inputDate &&
                             p.Status == "Pending" &&
                             p.IsAction == false &&
                             p.EndDateInt == inputDate ? 1 : 0)),
                             Closed_Before_TAT = g.Sum(p => (
                             p.EndDateInt > inputDate &&
                             p.ActualEndDate < p.EndDateInt ? 1 : 0)),
                             Column5 = g.Sum(p => (
                             p.EndDateInt > inputDate &&
                             p.Status == "Hold" ? 1 : 0)),
                             Column6 = g.Sum(p => (
                             p.EndDateInt > inputDate &&
                             (p.Status == "WIP" ||
                             p.Status == "Sent to Review" ||
                             p.Status == "Approved" ||
                             p.Status == "Rejected") ? 1 : 0)),
                             Column7 = g.Sum(p => (
                             p.EndDateInt > inputDate &&
                             p.Status == "Pending" &&
                             p.IsAction == false &&
                             p.EndDateInt == inputDate ? 1 : 0))

                         };

            }
            catch (Exception es)
            {

                throw;
            }
        }

        public IEnumerable<SubTaskDetail> SubReportDetail(string taskType, int locationId ,DateTime inputDate)
        {
            WebApplication4.eClose_DevEntities context = new WebApplication4.eClose_DevEntities();

            IQueryable<SubTaskDetail> taskDetails= (from wbusr in context.WorkbasketTaskUsers
                                                   join wfl in context.WorkflowLevels
                                                         on new { WorkflowId = (int)(wbusr.WorkbasketTask.WorkflowId), Level = wbusr.WorkbasketTask.WorkflowAction.WorkflowLevel }
                                                     equals new { wfl.WorkflowId, wfl.Level }
                                                   where
                                                     wbusr.WorkbasketTask.Period.LocationId == locationId
                                                   select new SubTaskDetail
                                                   {
                                                       LocationId = (int?)wbusr.WorkbasketTask.Period.LocationId,
                                                       Status = wbusr.WorkbasketTask.WorkflowAction.Status,
                                                       TaskName = wbusr.WorkbasketTask.TaskName,
                                                       EndDateInt = wbusr.EndDateInt,
                                                       ActualEndDate = wbusr.ActualEndDate,
                                                       IsAction = (bool?)wbusr.WorkbasketTask.WorkflowAction.IsAction
                                                   });
            switch (taskType)
            {
                case  "LocationId":
                    return taskDetails;
                case  "PastClosedWithinTAT":
                    return taskDetails.Where(p => p.EndDateInt < inputDate &&
                                  p.ActualEndDate <= p.EndDateInt);
                case  "PastClosedTATMissed":
                     return taskDetails.Where(p => 
                                   p.EndDateInt < inputDate &&
                                   p.ActualEndDate > p.EndDateInt);
                case  "PastOpenOnHold":
                     return taskDetails.Where(p => (
                                   p.EndDateInt < inputDate &&
                                   p.ActualEndDate > p.EndDateInt &&
                                   (p.Status == "Inputs Awaited" ||
                                   p.Status == "System Issue" ||
                                   p.Status == "Queried to Sivantos")));
                case  "PastOpenWIP":
                     return taskDetails.Where(p => (
                                   p.EndDateInt < inputDate &&
                                   p.ActualEndDate > p.EndDateInt &&
                                   (p.Status == "WIP" ||
                                   p.Status == "Sent to Review" ||
                                   p.Status == "Approved" ||
                                   p.Status == "Rejected") ));
                case  "PastOpenUnActioned":
                    return taskDetails.Where(p => (
                                     p.EndDateInt < inputDate &&
                                     p.Status == "Pending" &&
                                     p.IsAction == false ));
                case  "TodayClosedWithinTAT":
                     return taskDetails.Where(p => (
                                   p.EndDateInt == inputDate &&
                                   p.ActualEndDate == p.EndDateInt));
                case  "TodayOpenOnHold":
                    return taskDetails.Where(p => (
                                  p.EndDateInt == inputDate &&
                                  p.Status == "Hold"));
                case  "TodayOpenWIP":
                     return taskDetails.Where(p => (
                                   p.EndDateInt == inputDate &&
                                   (p.Status == "WIP" ||
                                   p.Status == "Sent to Review" ||
                                   p.Status == "Approved" ||
                                   p.Status == "Rejected")));
                case  "TodayOpenUnActioned":
                    return taskDetails.Where(p => (
                                  p.EndDateInt == inputDate &&
                                  p.Status == "Pending" &&
                                  p.IsAction == false &&
                                  p.EndDateInt == inputDate));

                case  "FutureClosedBeforeTAT":
                     return taskDetails.Where(p => (
                                   p.EndDateInt > inputDate &&
                                   p.ActualEndDate < p.EndDateInt ));
                case  "FutureOpenOnHold":
                    return taskDetails.Where(p => (
                                   p.EndDateInt > inputDate &&
                                   p.Status == "Hold"));

                case  "FutureOpenWIP":
                     return taskDetails.Where(p => (
                                   p.EndDateInt > inputDate &&
                                   (p.Status == "WIP" ||
                                   p.Status == "Sent to Review" ||
                                   p.Status == "Approved" ||
                                   p.Status == "Rejected")));
                case  "FutureOpenUnActioned":
                     return taskDetails.Where(p => (
                                   p.EndDateInt > inputDate &&
                                   p.Status == "Pending" &&
                                   p.IsAction == false &&
                                   p.EndDateInt == inputDate)) ;
                case  "PastTotal":
                     return taskDetails.Where(p => (
                                   p.EndDateInt < inputDate));
                case  "TodayTotal":
                     return taskDetails.Where(p => (
                                   p.EndDateInt == inputDate));
                case  "FutureTotal":
                     return taskDetails.Where(p => (
                                   p.EndDateInt > inputDate));
                default:
                    return taskDetails;

            }

        }
        public IEnumerable<SummaryInfo> SummaryReportOnDate(DateTime inputDate)
        {
            WebApplication4.eClose_DevEntities context = new WebApplication4.eClose_DevEntities();
            List<SummaryInfo> Summaryinfo = new List<SummaryInfo>();
            IEnumerable<SummaryInfo> SummaryList;

            try
            {

                SummaryList = (from result in
                                                (from wbusr in context.WorkbasketTaskUsers
                                                 join wfl in context.WorkflowLevels
                                                       on new { WorkflowId = (int)(wbusr.WorkbasketTask.WorkflowId), Level = wbusr.WorkbasketTask.WorkflowAction.WorkflowLevel }
                                                   equals new { wfl.WorkflowId, wfl.Level }
                                                 group new { wbusr.WorkbasketTask.Period, wbusr.WorkbasketTask.WorkflowAction, wbusr } by new
                                                 {
                                                     LocationId = (int?)wbusr.WorkbasketTask.Period.LocationId,
                                                     wbusr.WorkbasketTask.WorkflowAction.Status,
                                                     IsAction = (bool?)wbusr.WorkbasketTask.WorkflowAction.IsAction
                                                 } into g
                                                 select new
                                                 {
                                                     LocationId = (int?)g.Key.LocationId,
                                                     g.Key.Status,
                                                     EndDateInt = (DateTime?)g.Max(p => p.wbusr.EndDateInt),
                                                     ActualEndDate = (DateTime?)g.Max(p => p.wbusr.ActualEndDate),
                                                     IsAction = (bool?)g.Key.IsAction
                                                 })
                               group result by new
                               {
                                   result.LocationId
                               } into g
                               select new SummaryInfo
                               {
                                   LocationId = g.Key.LocationId,

                                   PastClosedWithinTAT = g.Sum(p => (
                                   p.EndDateInt < inputDate &&
                                   p.ActualEndDate <= p.EndDateInt ? 1 : 0)),

                                   PastClosedTATMissed = g.Sum(p => (
                                   p.EndDateInt < inputDate &&
                                   p.ActualEndDate > p.EndDateInt ? 1 : 0)),

                                   PastOpenOnHold = g.Sum(p => (
                                   p.EndDateInt < inputDate &&
                                   p.ActualEndDate > p.EndDateInt &&
                                   (p.Status == "Inputs Awaited" ||
                                   p.Status == "System Issue" ||
                                   p.Status == "Queried to Sivantos") ? 1 : 0)),

                                   PastOpenWIP = g.Sum(p => (
                                   p.EndDateInt < inputDate &&
                                   p.ActualEndDate > p.EndDateInt &&
                                   (p.Status == "WIP" ||
                                   p.Status == "Sent to Review" ||
                                   p.Status == "Approved" ||
                                   p.Status == "Rejected") ? 1 : 0)),

                                   PastOpenUnActioned = g.Sum(p => (
                                     p.EndDateInt < inputDate &&
                                     p.Status == "Pending" &&
                                     p.IsAction == false ? 1 : 0)),

                                   TodayClosedWithinTAT = g.Sum(p => (
                                   p.EndDateInt == inputDate &&
                                   p.ActualEndDate == p.EndDateInt ? 1 : 0)),

                                   TodayOpenOnHold = g.Sum(p => (
                                   p.EndDateInt == inputDate &&
                                   p.Status == "Hold" ? 1 : 0)),

                                   TodayOpenWIP = g.Sum(p => (
                                   p.EndDateInt == inputDate &&
                                   (p.Status == "WIP" ||
                                   p.Status == "Sent to Review" ||
                                   p.Status == "Approved" ||
                                   p.Status == "Rejected") ? 1 : 0)),

                                   TodayOpenUnActioned = g.Sum(p => (
                                   p.EndDateInt == inputDate &&
                                   p.Status == "Pending" &&
                                   p.IsAction == false &&
                                   p.EndDateInt == inputDate ? 1 : 0)),

                                   FutureClosedBeforeTAT = g.Sum(p => (
                                   p.EndDateInt > inputDate &&
                                   p.ActualEndDate < p.EndDateInt ? 1 : 0)),

                                   FutureOpenOnHold = g.Sum(p => (
                                   p.EndDateInt > inputDate &&
                                   p.Status == "Hold" ? 1 : 0)),

                                   FutureOpenWIP = g.Sum(p => (
                                   p.EndDateInt > inputDate &&
                                   (p.Status == "WIP" ||
                                   p.Status == "Sent to Review" ||
                                   p.Status == "Approved" ||
                                   p.Status == "Rejected") ? 1 : 0)),

                                   FutureOpenUnActioned = g.Sum(p => (
                                   p.EndDateInt > inputDate &&
                                   p.Status == "Pending" &&
                                   p.IsAction == false &&
                                   p.EndDateInt == inputDate ? 1 : 0)),

                                   PastTotal = 0,
                                   TodayTotal = 0,
                                   FutureTotal = 0,
                                   Total = 0
                               }).ToList<SummaryInfo>();

                foreach (var data in SummaryList)
                {
                    Summaryinfo.Add(data);
                }


                List<SummaryInfo> finalSummaryList = new List<SummaryInfo>();
                finalSummaryList = (from result in Summaryinfo
                                    select new SummaryInfo
                                    {
                                        LocationId = result.LocationId,
                                        PastClosedWithinTAT = result.PastClosedWithinTAT,
                                        PastClosedTATMissed = result.PastClosedTATMissed,
                                        PastOpenOnHold = result.PastOpenOnHold,


                                        PastOpenWIP = result.PastOpenWIP,

                                        PastOpenUnActioned = result.PastOpenUnActioned,

                                        TodayClosedWithinTAT = result.TodayClosedWithinTAT,

                                        TodayOpenOnHold = result.TodayOpenOnHold,

                                        TodayOpenWIP = result.TodayOpenWIP,

                                        TodayOpenUnActioned = result.TodayOpenUnActioned,

                                        FutureClosedBeforeTAT = result.FutureClosedBeforeTAT,

                                        FutureOpenOnHold = result.FutureOpenOnHold,

                                        FutureOpenWIP = result.FutureOpenWIP,

                                        FutureOpenUnActioned = result.FutureOpenUnActioned,
                                        PastTotal = result.PastClosedWithinTAT + result.PastClosedTATMissed + result.PastOpenOnHold + result.PastOpenWIP + result.PastOpenUnActioned,
                                        TodayTotal = result.TodayClosedWithinTAT + result.TodayOpenOnHold + result.TodayOpenWIP + result.TodayOpenUnActioned,
                                        FutureTotal = result.FutureClosedBeforeTAT + result.FutureOpenOnHold + result.FutureOpenWIP + result.FutureOpenWIP,

                                        Total = result.PastClosedWithinTAT + result.PastClosedTATMissed + result.PastOpenOnHold + result.PastOpenWIP + result.PastOpenUnActioned
                                                 + result.TodayClosedWithinTAT + result.TodayOpenOnHold + result.TodayOpenWIP + result.TodayOpenUnActioned
                                                 + result.FutureClosedBeforeTAT + result.FutureOpenOnHold + result.FutureOpenWIP + result.FutureOpenWIP

                                    }).ToList<SummaryInfo>();

                return (finalSummaryList);
            }
            catch (Exception es)
            {
                throw;
            }
        }
    }
}
    
