﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace SmashcloudTollManagment.Models
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class Entities : DbContext
    {
        public Entities()
            : base("name=Entities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
    
        public virtual ObjectResult<Nullable<decimal>> EnterVehicle(Nullable<int> enteringTollInterChangeId, Nullable<System.DateTime> enteringDateTime, string vehicleNumberPlate, string addedBy)
        {
            var enteringTollInterChangeIdParameter = enteringTollInterChangeId.HasValue ?
                new ObjectParameter("EnteringTollInterChangeId", enteringTollInterChangeId) :
                new ObjectParameter("EnteringTollInterChangeId", typeof(int));
    
            var enteringDateTimeParameter = enteringDateTime.HasValue ?
                new ObjectParameter("EnteringDateTime", enteringDateTime) :
                new ObjectParameter("EnteringDateTime", typeof(System.DateTime));
    
            var vehicleNumberPlateParameter = vehicleNumberPlate != null ?
                new ObjectParameter("VehicleNumberPlate", vehicleNumberPlate) :
                new ObjectParameter("VehicleNumberPlate", typeof(string));
    
            var addedByParameter = addedBy != null ?
                new ObjectParameter("AddedBy", addedBy) :
                new ObjectParameter("AddedBy", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Nullable<decimal>>("EnterVehicle", enteringTollInterChangeIdParameter, enteringDateTimeParameter, vehicleNumberPlateParameter, addedByParameter);
        }
    
        public virtual ObjectResult<GetAndUpdateVehicleExit_Result> GetAndUpdateVehicleExit(string vehicleNumberPlate, Nullable<int> exitingTollInterChangeId, Nullable<System.DateTime> exitingDateTime, string updatedBy)
        {
            var vehicleNumberPlateParameter = vehicleNumberPlate != null ?
                new ObjectParameter("VehicleNumberPlate", vehicleNumberPlate) :
                new ObjectParameter("VehicleNumberPlate", typeof(string));
    
            var exitingTollInterChangeIdParameter = exitingTollInterChangeId.HasValue ?
                new ObjectParameter("ExitingTollInterChangeId", exitingTollInterChangeId) :
                new ObjectParameter("ExitingTollInterChangeId", typeof(int));
    
            var exitingDateTimeParameter = exitingDateTime.HasValue ?
                new ObjectParameter("ExitingDateTime", exitingDateTime) :
                new ObjectParameter("ExitingDateTime", typeof(System.DateTime));
    
            var updatedByParameter = updatedBy != null ?
                new ObjectParameter("UpdatedBy", updatedBy) :
                new ObjectParameter("UpdatedBy", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GetAndUpdateVehicleExit_Result>("GetAndUpdateVehicleExit", vehicleNumberPlateParameter, exitingTollInterChangeIdParameter, exitingDateTimeParameter, updatedByParameter);
        }
    
        public virtual ObjectResult<GetSpecialDays_Result> GetSpecialDays(Nullable<System.DateTime> exitDate)
        {
            var exitDateParameter = exitDate.HasValue ?
                new ObjectParameter("exitDate", exitDate) :
                new ObjectParameter("exitDate", typeof(System.DateTime));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GetSpecialDays_Result>("GetSpecialDays", exitDateParameter);
        }
    
        public virtual ObjectResult<GetTollInterchange_Result> GetTollInterchange(Nullable<int> tollInterchangeId)
        {
            var tollInterchangeIdParameter = tollInterchangeId.HasValue ?
                new ObjectParameter("TollInterchangeId", tollInterchangeId) :
                new ObjectParameter("TollInterchangeId", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GetTollInterchange_Result>("GetTollInterchange", tollInterchangeIdParameter);
        }
    }
}
