using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading;

namespace Kestrel.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class StressController : ControllerBase
    {
        // GET api/stress
        [HttpGet]
        public ActionResult<string> Get()
        {
            var lista = new List<byte[]>();
            for (int i = 0; i < 300; i++)
            {
                lista.Add(new byte[1024 * 1024 * 1024]); // Aloca 1MB
            }
            return "Memory Stress";
        }

    }
}
