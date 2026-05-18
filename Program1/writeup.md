```markdown
# Program 1 Write-up: Solving Approach & AI Log

## 1. Description of Solving Approach
My implementation approaches this constraint-satisfaction problem using a recursive depth-first backtracking search built entirely from scratch, avoiding any external solver frameworks[cite: 6, 59]. Before launching the search, the script calculates the exact uniform workload constraint ($K = N / M$) that every volunteer must satisfy[cite: 12]. To ensure the algorithm easily scales and meets the mandatory 3-minute performance window [cite: 51], it implements the Most Constrained Variable (MRV) heuristic[cite: 81]. It accomplishes this by compiling an inverse lookup mapping every shift to its total pool of eligible volunteers, then sorting the execution sequence to resolve the shifts with the fewest valid options first[cite: 81].

During execution, the backtracking engine loops through these sorted shifts. For each shift, it evaluates the candidates from the pre-filtered availability list[cite: 13]. The state space is aggressively pruned early by checking each candidate's ongoing assignment tally; if a volunteer has already filled their calculated quota ($K$), they are skipped immediately[cite: 81]. If a branch eventually violates a constraint down the line, the algorithm rolls back the assignments up to that point and tries the next viable option until the singular, valid solution matrix is resolved.

## 2. AI Use Log for Input Parsing
As permitted by the course guidelines, an AI assistant was utilized exclusively to generate the regular expression patterns and text-file streaming loop required to safely capture the input parameters[cite: 56].

### Exact Prompt Sent to AI
> "Write a Python function called parse_puzzle(file_path) that reads a text file containing Prolog facts. It needs to parse two kinds of facts while ignoring any empty lines or lines that start with the '%' character. 
> The facts look like this:
> shift(1, 'Cake Stall', '10:00').
> available(alice, [1,11,13]).
> The function should return two dictionaries: 'shifts' where the key is the integer ID and the value is a tuple of (Stall Name, Time), and 'availabilities' where the key is the string name and the value is a list of integer shift IDs." [cite: 57, 61]













### Exact Verbatim AI Response
```python
import re

def parse_puzzle(file_path):
    shifts = {}
    availabilities = {}
    
    shift_re = re.compile(r"shift\s*\(\s*(\d+)\s*,\s*'([^']+)'\s*,\s*'([^']+)'\s*\)")
    avail_re = re.compile(r"available\s*\(\s*([a-zA-Z0-9_]+)\s*,\s*\[([^\]]*)\]\s*\)")

    with open(file_path, 'r') as f:
        for line in f:
            line = line.strip()
            if line.startswith('%') or not line:
                continue
            
            s_match = shift_re.search(line)
            if s_match:
                s_id = int(s_match.group(1))
                stall = s_match.group(2)
                time = s_match.group(3)
                shifts[s_id] = (stall, time)
                continue
                
            a_match = avail_re.search(line)
            if a_match:
                name = a_match.group(1)
                id_str = a_match.group(2).strip()
                ids = [int(x.strip()) for x in id_str.split(',')] if id_str else []
                availabilities[name] = ids

    return shifts, availabilities