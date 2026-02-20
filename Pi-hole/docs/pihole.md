# How Pi-hole Works

Pi-hole is a DNS sinkhole ad, trackingand malware blocker that works on the DNS level. That is to say it covers every device on your network, without you needing to install anything at all on those devices. It'll run on browsers,smart TVS,mobile phones, tablets and game consoles you name it as long as they are connected to the network.  
This is the document that describes what all of these means: Pi-hole glossary This way one will understand what DNS, purposes as a sinkhole, block lists and NXDOMAIN mean. It helps to know about these topics before installing or configuring Pi-hole.

---

## What is DNS?

**DNS= Domain Name System**. It’sbasically the phone book ofthe web.

When you type `www. google. com`) in a browser, your device doesn’t actually have any idea where it is. It only speaks IPnumeric addresses (e.g., `142.250.74.46`). DNS does translation of human-readable domain names into machinereadable IP addresses.

The process works like this:

1. You type `www. google. com` in your browser  
2. A DNS request is made from your device to some DNS server (questioning “which IP address does this domain have”).  
3. theDNSservergivesus(notinthepost) the IPaddress….  
4. Your browser requests the page at that IPaddress and is served, with regardless of whether it was requested from example.com or not.  

And it all happens within milliseconds, and for every single domain a user’s device attempts to connect to including not just the website but every commonplace ad, tracker, analytics script and third-party content the page tries to load.

---

## What is a DNS Sinkhole?

DNS sinkhole A DNS server that returns either bogus or empty results for selected addresses, to( mis)direct traffic.

Pi-hole is a middle man it’s basically inserting itself between your browser, and the DNS server you use to find out where domains are. They do that for every single DNS query on your network. The requested domain is then compared to the blocklist which Pi-hole maintains:

- If the domain **is not** found in the blocklist, Pi-hole passes it on to your upstream DNS server, and you get the real IP. The content loads.  
- If the domain **is** on the blocklist, Pi-holeblocks immediately and responds with an NXDOMAIN telling the client it does not exist.  

The device receives thatreply and stops trying to load thecontent, continuing with the next one. With no successful connection being established thead, tracker or unwanted script is never loaded.

---

## What is NXDOMAIN?

NXDOMAIN stands for **Non-Existent Domain**. Itis a generic status code that indicates that the domain is not found.

You'd get the same response if entered into your browser's address box a non-existent domain name (at all). As a result, your device sees it as no throughroad and will not attempt to connect. This fits with Pi-hole’s way of filtering content it doesn’t inspect web traffic and does not interfere on the connection level. Itanswers the DNS query before any connection is made.

---

## What are Blocklists?

Blocklists are exactly what they sound like a list of domains to block and Pi-hole works from the lists backwards to figure out what sh-t to block. They arecommunity-supported and updated frequently. Pi-hole comes with a default blocklist, which is extendible.

When Pi-hole receives a DNS query, it checks the domain against all blocklists you are using. On a match, the domain is blocked. If not, however,a pass is permitted.

Someof the most used blocklists people use with Pi-hole:

- **StevenBlack's Hosts** consolidated hosts file to block air andmalwaresites  
- **The OISD blocklist**  A good catch all list, but nice and loose.  
- **Hagezi’slists** level of lists in order for light-to heavy-blocking aggressive.  

You can also manually add or remove blocklists (and even modify their contents) from the Pi-hole web interface as well. You also have the ability to whitelist specific domains in case Pi-hole is causing it to block something that youactually want.

---

## What Does Pi-hole Block?

Pihole would reject anything who’s domain was on its banlist. In practice this includes:

- **Ads** banner ads, video pre-rolls,sponsored content  
- **Tracker** tracks your activity between websited.  
- **Telemetry** Information from smart T.V.’s, apps and operating systems  
- **malware domains:** known to be malicious, word in phishing or spreading malware  
- **Custom blocks** any hosts that you add to your own blocklist.  

It does not block content within a page it doesn’t, for example, neutralize a sponsored post served fromthe same domain as other page contents. It’s domain based onlyso really the best with 3rd party ad and tracker networks, etc that are on a separate domain.

---

## The Admin Dashboard

Statistics The data is available to view on the web interface of Pi-hole. This is accessible at `http://<pihole-ip>/admin`. It puts DNS activity in plain view on your networkand makes setting up Pi-hole a piece of cake (without using the command line).

From the dashboard you can:

- Monitor aggregate queries with blocked queries and percentage of block in realtime  
- Live query log displays all DNSqueries on your network  
- Add and manage blocklists  
- Allowlist or blocklist specificdomains  
- Review devices withmost queries  
- Block Temporarily without ending Pi-hole completely  

---

## Why would you run this in a VM instead of putting it on a Raspberry Pi?

Pi-hole was created to run on a Raspberry Pi an unvirtualized, if diminutive and low-power, piece of hardware. But when I'm actually setting it up in a VM and putting it on top of an existing Windows host, you get the exact same thing with some real world benefits for lab environments:

- No additional hardware required  
- Snapshots to facilitate easy roll-backs, resets and re-build of your environment.  
- Good for learningHyper-V/Virtualisation and Pi-hole  
- Pause and resume does not mess up permanent devices when paused/resumed.  

The downside is that the host machine has to be turned on in order for Pi-hole to operate. At a production home I assume you could argue, use a Raspberry Pi or something low powered. Random VM For Learning and Playing around.

---

## Practical Use Cases

**At home:**

- Ad block on YouTube, Smart TVs and Mobile Games over WiFi  
- Heavy pop-up blocking at the network level  
- Set per-device rules block social media on achild’s tablet, for example.  
- Level the playing field by disablingtelemetry from connected smart TV and IOT devices.  

**In a business or office:**

- Enforce a safe browsing experiencenetwork-wideall without touching individual devices  
- Block domains that phish and push out malware that you know they frequent before it hits the endpoint  
- Save Mobile Data from Ads and Tracking Scripts  
- Track 100% of DNS traffic for audit and diagnostic purposes  

---

## Further Reading

- [Pi-hole Documentation](https://docs.pi-hole.net/)  
- [Pi-hole Blocklist Overview](https://docs.pi-hole.net/guides/dns/blocklists/)  
- [Understanding DNS Cloudflare](https://www.cloudflare.com/learning/dns/what-is-dns/)  
