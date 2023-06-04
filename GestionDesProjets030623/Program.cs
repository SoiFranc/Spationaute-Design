using GestionDesProjets.Models;
using Microsoft.EntityFrameworkCore;
/*
namespace GestionDesProjets
{
    public class program 
    {
        public static void Main(string[] args) 
        {*/
            var builder = WebApplication.CreateBuilder(args);

            //Service connection string (!!!be before ...AddControllersWithViews)
            builder.Services.AddDbContext<SpationauteDesignBddContext>(options => options.UseSqlServer(builder.Configuration.GetConnectionString("ConnectSDBDD")));
            //builder.Services.AddSingleton<GestionDesProjetsContext>();

            // Add services to the container.
            builder.Services.AddControllersWithViews().AddRazorRuntimeCompilation(); ;

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (!app.Environment.IsDevelopment())
            {
                app.UseExceptionHandler("/Home/Error");
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }

            app.UseHttpsRedirection();
            app.UseStaticFiles();

            app.UseRouting();

            app.UseAuthorization();

            app.MapControllerRoute(
                name: "default",
                pattern: "{controller=Home}/{action=Index}/{id?}");

            app.Run();
       /* }
    }
}*/


