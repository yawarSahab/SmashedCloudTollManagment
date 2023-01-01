using SmashcloudTollManagment.Models;
using SmashcloudTollManagment.Models.BLL;
using SmashcloudTollManagment.Models.DAL;
using System.Collections.Generic;
using System.Web.Http;

namespace SmashcloudTollManagment.Controllers
{
    [Authorize] // Only request with auth token(Logged in users) in header can access it
    [RoutePrefix("api/TollPlaza")]
    public class TollPlazaController : ApiController
    {
       
        

            [HttpGet]
            [Route("GetAllTollInterchange")]
            public List<GetTollInterchange_Result> GetAllTollInterchange()
            {
               return new TollPlazaDAL().GetAllTollInterchange();
            }

            [HttpPost]
            [Route("AddVehicle")]
            public ResponseHelper AddVehicle(VehicleEntryHelper vehicleEntryHelperObj)
            {
                ResponseHelper responseHelperObj = new ResponseHelper();
                if (new TollPlazaBLL().VerifyVehicleNumberPlate(vehicleEntryHelperObj.VehicleNumberPlate) != null)
                {
                    responseHelperObj.InsertedId =  new TollPlazaDAL().AddVehicle(vehicleEntryHelperObj);
                }
                return responseHelperObj;
                
            }


            [HttpPost]
            [Route("CalculateTollTax")]
            public TollTaxHelper CalculateTollTax(VehicleExitHelper vehicleExitHelperObj)
            {
                return new TollPlazaBLL().CalculateTollTax(vehicleExitHelperObj);
            }



        
    }
}