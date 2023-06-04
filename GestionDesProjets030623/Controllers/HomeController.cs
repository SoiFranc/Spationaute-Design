using GestionDesProjets.Models;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;

namespace GestionDesProjets.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly SpationauteDesignBddContext spationauteDesignBddContext;

        public HomeController(ILogger<HomeController> logger, SpationauteDesignBddContext spationauteDesignBddContext)
        {
            _logger = logger;
            this.spationauteDesignBddContext = spationauteDesignBddContext;
        }

        public IActionResult Index()
        {
            var client = spationauteDesignBddContext.Clients.ToList();
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}