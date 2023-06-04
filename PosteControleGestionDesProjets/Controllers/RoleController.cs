using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace PosteControleGestionDesProjets.Controllers
{
    [Authorize]
    public class RoleController : Controller
    {
        private RoleManager<IdentityRole> _roleManager;
        private UserManager<IdentityUser> _userManager;

        //Add constructor  with roleManager parameter and his attribut just look-up to read all roles of table Roles in Database
        public RoleController(RoleManager<IdentityRole> roleManager, UserManager<IdentityUser> userManager )
        {
            _roleManager = roleManager;
            _userManager = userManager;
        }

		//Get all the Roles
		[Authorize(Roles = "Architecte")]
		public IActionResult Index()
        {
            var roles = _roleManager.Roles.ToList();
            return View(roles);
        }

		/*[Authorize(Roles = "Architecte")]*/
		[HttpGet]
		[Authorize(Roles = "Architecte")]
		public IActionResult CreateRole()
        {
            return View(new IdentityRole());
        }

        //Send to BDD the create Role
        [HttpPost]
        public async Task<IActionResult> CreateRole(IdentityRole role)
        {
            await _roleManager.CreateAsync(role);
            return View();
        }

		//Get my Roles, First get Email and get the user and the roles with userManager
		[Authorize]
		public async Task<IActionResult> GetMyRoles()
        {
            var userEmail = User.FindFirstValue(ClaimTypes.Email);
            var user = await _userManager.FindByEmailAsync(userEmail);
            var roles = await _userManager.GetRolesAsync(user);
            return View(roles);
        }
    }
}
