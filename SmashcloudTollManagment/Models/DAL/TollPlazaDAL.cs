using SmashcloudTollManagment.Models.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SmashcloudTollManagment.Models.DAL
{
    public class TollPlazaDAL
    {
        public List<GetTollInterchange_Result> GetAllTollInterchange()
        {
            using (Entities _Entities = new Entities())
            {
                // get all interchanges by passing null to get a specific interchange pass that interchangeId
                return _Entities.GetTollInterchange(null).ToList<GetTollInterchange_Result>();
            }
        }

        public decimal? AddVehicle(VehicleEntryHelper vehicleEntryHelperObj)
        {
            using (Entities _Entities = new Entities())
            {
                List<decimal?> TollEntryAndExitIdResultSet = _Entities.EnterVehicle(vehicleEntryHelperObj.EnteringTollInterChangeId, vehicleEntryHelperObj.EnteringDateTime, vehicleEntryHelperObj.VehicleNumberPlate, vehicleEntryHelperObj.AddedBy).ToList<decimal?>();
                if (TollEntryAndExitIdResultSet.Count > 0)
                {
                    return TollEntryAndExitIdResultSet[0];
                }
                else
                {
                    return null;
                }
            }
        }

        public List<GetAndUpdateVehicleExit_Result> GetAndUpdateVehicleExit(VehicleExitHelper vehicleExitHelperObj)
        {
            using (Entities _Entities = new Entities())
            {
                return _Entities.GetAndUpdateVehicleExit(vehicleExitHelperObj.VehicleNumberPlate, vehicleExitHelperObj.ExitingTollInterChangeId, vehicleExitHelperObj.ExitingDateTime, vehicleExitHelperObj.UpdatedBy).ToList<GetAndUpdateVehicleExit_Result>();

            }
        }


        public List<GetSpecialDays_Result> GetSpecialDays(DateTime ExitDate)
        {
            using (Entities _Entities = new Entities())
            {
                return _Entities.GetSpecialDays(ExitDate).ToList<GetSpecialDays_Result>();

            }
        }


    }
}