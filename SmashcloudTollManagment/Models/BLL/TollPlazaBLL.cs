using SmashcloudTollManagment.Models.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SmashcloudTollManagment.Models.BLL
{
    public class TollPlazaBLL
    {
        public TollTaxHelper CalculateTollTax(VehicleExitHelper vehicleExitHelperObj)
        {
            TollTaxHelper tollTaxHelperObj = new TollTaxHelper();
            TollPlazaDAL tollPlazaDAL = new TollPlazaDAL();
            TollManagmentConstants tollManagmentConstantsObj = new TollManagmentConstants();

            List<GetAndUpdateVehicleExit_Result> VehicleExitInfoList =   tollPlazaDAL.GetAndUpdateVehicleExit(vehicleExitHelperObj);
            if(VehicleExitInfoList.Count > 0)
            {
               List<GetSpecialDays_Result> specialDaysList =  tollPlazaDAL.GetSpecialDays(vehicleExitHelperObj.ExitingDateTime);
                if(specialDaysList.Count > 0)
                {
                    int? numericVehicleNumber = VerifyVehicleNumberPlate(vehicleExitHelperObj.VehicleNumberPlate);
                    if (numericVehicleNumber != null)
                    {
                       
                        tollTaxHelperObj.TollTaxBaseRate = TollManagmentConstants.TollTaxBaseRate;
                        tollTaxHelperObj.PerKmRate = TollManagmentConstants.PerKmCharges;

                        if (vehicleExitHelperObj.ExitingDateTime.DayOfWeek == DayOfWeek.Saturday || vehicleExitHelperObj.ExitingDateTime.DayOfWeek == DayOfWeek.Sunday){
                            if(specialDaysList[0].ExtraChargeAmountPercentage != null)
                            {
                                tollTaxHelperObj.PerKmRate += (double)specialDaysList[0].ExtraChargeAmountPercentage;
                            }
                           
                        }
                        tollTaxHelperObj.PerKmCost = tollTaxHelperObj.TollTaxBaseRate +  (tollTaxHelperObj.PerKmRate * (VehicleExitInfoList[0].ExitingDistanceInKm - VehicleExitInfoList[0].EnteringDistanceInKm));
                        tollTaxHelperObj.DistanceTravelledInKm = VehicleExitInfoList[0].ExitingDistanceInKm - VehicleExitInfoList[0].EnteringDistanceInKm;

                        tollTaxHelperObj.TotalTaxAmount = tollTaxHelperObj.PerKmCost - tollTaxHelperObj.DiscountAmount;
                        if (specialDaysList[0].DiscountPercentage != null)
                        {
                            // checking for even number plates
                            if (specialDaysList[0].SpecialDiscountTypeId == TollManagmentConstants.EvenPlatenumbersType)
                            {
                                if(numericVehicleNumber % 2 == 0)
                                {
                                    tollTaxHelperObj.DiscountAmount = ( ( tollTaxHelperObj.TotalTaxAmount * (double)specialDaysList[0].DiscountPercentage ) / 100 ) ;
                                }
                            } // checking for Odd number plates
                            else if (specialDaysList[0].SpecialDiscountTypeId == TollManagmentConstants.OddPlatenumbersType)
                            {
                                if (numericVehicleNumber % 2 != 0)
                                {
                                    tollTaxHelperObj.DiscountAmount = ((tollTaxHelperObj.TotalTaxAmount * (double)specialDaysList[0].DiscountPercentage) / 100);
                                }
                            }

                        }
                        tollTaxHelperObj.TotalTaxAmount -= tollTaxHelperObj.DiscountAmount;
                        tollTaxHelperObj.EntryInterchangeTitle = VehicleExitInfoList[0].EnteringTollInterchangeTitle;
                        tollTaxHelperObj.ExitInterchangeTitle = VehicleExitInfoList[0].ExitingTollInterchangeTitle;
                        tollTaxHelperObj.EntryDateTime = VehicleExitInfoList[0].EnteringDateTime;
                        tollTaxHelperObj.ExitDateTime = VehicleExitInfoList[0].ExitingDateTime;
                        tollTaxHelperObj.VehiclePlatNumber = VehicleExitInfoList[0].VehicleNumberPlate;
                    }
                    else
                    {
                        tollTaxHelperObj = new TollTaxHelper();
                        tollTaxHelperObj.ResponseMessage = vehicleExitHelperObj.VehicleNumberPlate + " is not a valid vehicle number ";
                        return tollTaxHelperObj;
                    }
                    
                }
            }
            else
            {
                tollTaxHelperObj.ResponseMessage = vehicleExitHelperObj.VehicleNumberPlate + " Do not have any entry point or has exited already";
            }
            return tollTaxHelperObj;
        }
        
        public int? VerifyVehicleNumberPlate(String VehicleNumberPlate)
        {
            // casting last three digits of vehicle number plate into int
            if (Int32.TryParse(VehicleNumberPlate.Split('-')[1], out int numericVehicleNumber))
            {
                return numericVehicleNumber;
            }
            else
            {
                // vehicle plate numer is not  valid add log 
                return null;
            }
        }

        //protected Double GetDiscountAmount(GetGetSpecialDays_Result specialDay, DateTime Exitdate, int VehicleNumericPlateNumber)
        //{
        //    if(specialDay.DiscountPercentage > 0)
        //    {

        //    }
        //    return 2;
        //}
    }
}