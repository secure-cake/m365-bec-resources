# Misc M365 BEC Resources

This is just a compilation of M365 "business email compromise" (BEC) investigative tools, notes, etc. M365 is in "constant development," so things change rapidly and, as usual, I'm a fan of simple, lightweight "tools" (scripts, whatever) that help me (you!) quickly, accessibly (meaning it's important we undertsand what any "tool" is doing!) answer investigative questions!

## Unified Audit Log (UAL) Export in JSON for SOF-ELK
It's no secret that I'm a huge fan of [SOF-ELK](https://github.com/philhagen/sof-elk). Pulling the UAL can be finicky and there are many, many complicated scripts that help with this! But...I like mine, because it's simple! I usually want to investigate a single user during a specific period of time, and the [ual-export-for-sof-elk](https://github.com/secure-cake/m365-bec-resources/blob/main/ual-export-for-sof-elk)  does precisely that, outputing results into a single JSON file for ingestion into SOF-ELK. You can also use it to export all users but again, I like "targeted," finite queries as much as possible. 

## M365 Permissions
Yeah...
