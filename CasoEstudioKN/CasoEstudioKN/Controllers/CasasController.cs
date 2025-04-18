using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CasoEstudioKN.BaseDatos;
using CasoEstudioKN.Models;

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
            {
                try
                {
                    using (var context = new CasoEstudioKNEntities())
                    {
                        var casas = context.SP_ObtenerCasasFiltradas().ToList();

                        return View(casas);
                    }
                }
                catch
                {
                    return View("Error");
                }
            }
        }
        #endregion

        #region Alquilar
        [HttpGet]
        public ActionResult Alquilar(long? idCasaSeleccionada)
        {
            try
            {
                using (var context = new CasoEstudioKNEntities())
                {
                    var casasDisponibles = context.SP_ListarCasas()
                        .Select(c => new CasasModel
                        {
                            IdCasa = c.IdCasa,
                            DescripcionCasa = c.DescripcionCasa,
                            PrecioCasa = c.PrecioCasa
                        }).ToList();

                    ViewBag.CasasDisponibles = new SelectList(casasDisponibles, "IdCasa", "DescripcionCasa", idCasaSeleccionada);

                    var modelo = idCasaSeleccionada.HasValue
                        ? casasDisponibles.FirstOrDefault(c => c.IdCasa == idCasaSeleccionada.Value)
                        : new CasasModel();

                    return View(modelo);
                }
            }
            catch
            {
                return View("Error");
            }
        }



        // Vista: Alquiler de casas (POST)
        [HttpPost]
        public ActionResult Alquilar(CasasModel model)
        {
            try
            {
                using (var context = new CasoEstudioKNEntities())
                {
                    context.SP_AlquilarCasa(model.IdCasa, model.UsuarioAlquiler);
                    return RedirectToAction("Consultar");
                }
            }
            catch
            {
                return View("Error");
            }
        }
        #endregion
    }
}