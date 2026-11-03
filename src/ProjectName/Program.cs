var builder = WebApplication.CreateBuilder(args);

var app = builder.Build();

app.MapGet("/", () => "ProjectName is running");

app.Run();
