using Microsoft.AspNetCore.Mvc;
using System;

namespace api.Controllers;

[ApiController]
[Route("/")]
public class MainController : ControllerBase
{

    [HttpGet(Name = "/")]
    public string Get()
    {
        string? message = Environment.GetEnvironmentVariable("MESSAGE");
        string? sleepEnv = Environment.GetEnvironmentVariable("SLEEP");
        int sleepValue = string.IsNullOrWhiteSpace(sleepEnv) ? 0 : Int32.Parse(sleepEnv);

        message = string.IsNullOrEmpty(message) ? "Version:1. No environment variable specified. Please specify MESSAGE environment variable." : message;
        Thread.Sleep(sleepValue);

        return $"{message + $" Sleep Value: {sleepValue}"}";
    }
}