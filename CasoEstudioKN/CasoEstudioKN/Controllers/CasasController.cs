using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CasoEstudioKN.Controllers
{
    public class CasasController : Controller
    {
        #region Inicio
        // GET: Casas
        public ActionResult Index()
        {
            try
            {
                return View();

            }
            catch (Exception ex)
            {
                return View("Error");
            }
        }
        #endregion

        #region Consultar
        [HttpGet]
        public ActionResult Consultar()
        {
            try
            {
                return View();
            }
            catch (Exception ex)
            {
                return View("Error");
            }
        }
        #endregion

        #region Alquilar
        [HttpGet]
        public ActionResult Alquilar()
        {
            return View();
        }
        #endregion
    }
}