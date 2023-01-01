
namespace SmashcloudTollManagment.Models.BLL
{
    public class TollManagmentConstants
    {
        public const double TollTaxBaseRate = 20;
        public const double PerKmCharges = 0.2;
        public const int EvenPlatenumbersType = 1;
        public const int OddPlatenumbersType = 2;
        public const int AllPlatenumbersType = 3;
    }

    public class ResponseHelper
    {
        public decimal? InsertedId { get; set; } = null;
        public string ResponseMessage { get; set; } = "Added Successfully";
    }
}