using Microsoft.AspNetCore.Mvc;

namespace api.Controllers;

[ApiController]
[Route("/")]
public class MainController : ControllerBase
{

    [HttpGet(Name = "/")]
    public string Get()
    {
        string? message = Environment.GetEnvironmentVariable("MESSAGE");

        message = string.IsNullOrEmpty(message) ? "Version:1. No environment variable specified. Please specify MESSAGE environment variable." : message;

        return $"V2: {message}" ;
    }
}