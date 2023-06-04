using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using GestionDesProjets.Models;

namespace GestionDesProjets.Controllers
{
    public class ClientsController : Controller
    {
        private readonly SpationauteDesignBddContext _context;

        public ClientsController(SpationauteDesignBddContext context)
        {
            _context = context;
        }

        // GET: Clients
        public async Task<IActionResult> Index(string sortOrder, string searchString)
        {
            //Add links Sort columns + search area
            ViewData["NameSortParm"] = String.IsNullOrEmpty(sortOrder) ? "name_desc" : "";
            ViewData["FirstnameSortParm"] = String.IsNullOrEmpty(sortOrder) ? "firstname_desc" : "";

            ViewData["CurrentFilter"] = searchString;
            /*ViewData["DateSortParm"] = sortOrder == "Date" ? "date_desc" : "Date";*/

            /*var spationauteDesignBddContext = _context.Clients.Include(c => c.IdUtilisateurNavigation);*/
            var clients = from c in _context.Clients.Include(c => c.IdUtilisateurNavigation) select c;

            if (!String.IsNullOrEmpty(searchString))
            {
                clients = clients.Where(c => c.Name.Contains(searchString.ToUpper()) || c.Firstname.Contains(searchString.ToUpper()));
            }

            switch (sortOrder)
            {
                case "name_desc":
                    clients = clients.OrderByDescending(c => c.Name);
                    break;
                case "firstname":
                    clients = clients.OrderBy(c => c.Firstname);
                    break;
                case "firstname_desc":
                    clients = clients.OrderByDescending(c => c.Firstname);
                    break;
                default:
                    clients = clients.OrderBy(c => c.Name);
                    break;
            }
                    /*return View(await spationauteDesignBddContext.ToListAsync());*/
                    return View(await clients.AsNoTracking().ToListAsync());
        }

        // GET: Clients/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null || _context.Clients == null)
            {
                return NotFound();
            }

            var client = await _context.Clients
                .Include(c => c.IdUtilisateurNavigation)
                .FirstOrDefaultAsync(m => m.IdClient == id);
            if (client == null)
            {
                return NotFound();
            }

            return View(client);
        }

        // GET: Clients/Create
        public IActionResult Create()
        {
            ViewData["IdUtilisateur"] = new SelectList(_context.Utilisateurs, "IdUtilisateur", "Firstname");
            return View();
        }

        // POST: Clients/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("IdClient,Firstname,Name,Adress,Tel,Mail,IsActivate,IsPro,NumSiret,TvaIntracom,CodeApe,NomActivitePro,AdrActivitePro,Commentaire,IdUtilisateur")] Client client)
        {
            if (ModelState.IsValid)
            {
                _context.Add(client);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["IdUtilisateur"] = new SelectList(_context.Utilisateurs, "IdUtilisateur", "Firstname", client.IdUtilisateur);
            return View(client);
        }

        // GET: Clients/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null || _context.Clients == null)
            {
                return NotFound();
            }

            var client = await _context.Clients.FindAsync(id);
            if (client == null)
            {
                return NotFound();
            }
            ViewData["IdUtilisateur"] = new SelectList(_context.Utilisateurs, "IdUtilisateur", "Firstname", client.IdUtilisateur);
            return View(client);
        }

        // POST: Clients/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("IdClient,Firstname,Name,Adress,Tel,Mail,IsActivate,IsPro,NumSiret,TvaIntracom,CodeApe,NomActivitePro,AdrActivitePro,Commentaire,IdUtilisateur")] Client client)
        {
            if (id != client.IdClient)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(client);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ClientExists(client.IdClient))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            ViewData["IdUtilisateur"] = new SelectList(_context.Utilisateurs, "IdUtilisateur", "Firstname", client.IdUtilisateur);
            return View(client);
        }

        // GET: Clients/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null || _context.Clients == null)
            {
                return NotFound();
            }

            var client = await _context.Clients
                .Include(c => c.IdUtilisateurNavigation)
                .FirstOrDefaultAsync(m => m.IdClient == id);
            if (client == null)
            {
                return NotFound();
            }

            return View(client);
        }

        // POST: Clients/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            if (_context.Clients == null)
            {
                return Problem("Entity set 'SpationauteDesignBddContext.Clients'  is null.");
            }
            var client = await _context.Clients.FindAsync(id);
            if (client != null)
            {
                _context.Clients.Remove(client);
            }
            
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool ClientExists(int id)
        {
          return (_context.Clients?.Any(e => e.IdClient == id)).GetValueOrDefault();
        }
    }
}
