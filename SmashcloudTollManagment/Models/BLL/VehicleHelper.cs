using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SmashcloudTollManagment.Models.BLL
{
    public class VehicleEntryHelper
    {
        public int EnteringTollInterChangeId { get; set; }
        public DateTime EnteringDateTime { get; set; }
        public string VehicleNumberPlate { get; set; }
        public string AddedBy { get; set; }
    }

    public class VehicleExitHelper
    {
        public int ExitingTollInterChangeId { get; set; }
        public DateTime ExitingDateTime { get; set; }
        public string VehicleNumberPlate { get; set; }
        public string UpdatedBy { get; set; }
    }

    public class TollTaxHelper
    {
        public Double TollTaxBaseRate { get; set; }
        public Double DistanceTravelledInKm { get; set; }
        public Double PerKmRate { get; set; }
        public Double PerKmCost { get; set; } = 0;
        public Double DiscountAmount { get; set; } = 0;
        public Double TotalTaxAmount { get; set; } = 0;
        public String ResponseMessage { get; set; } = "Vehicle marked as Exit Successfully";
        public DateTime EntryDateTime { get; set; }
        public DateTime? ExitDateTime { get; set; }
        public String EntryInterchangeTitle { get; set; }
        public String ExitInterchangeTitle { get; set; }
        public String VehiclePlatNumber { get; set; }

    }
}