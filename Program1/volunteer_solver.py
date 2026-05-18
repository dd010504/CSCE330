"""
CSCE 330 - Program 1: Charity Stall Volunteer Scheduling
Student Submission
"""

import sys
import re

# =============================================================================
# 1. PARSER PORTION (Generated with AI Assistance)
# =============================================================================
def parse_puzzle(file_path):
    """
    Reads a Prolog-style puzzle file, strips out comments, and extracts 
    the shift definitions and volunteer availability lists.
    """
    shifts = {}
    availabilities = {}
    
    # Regex patterns to isolate the relevant data fields from the facts
    shift_re = re.compile(r"shift\s*\(\s*(\d+)\s*,\s*'([^']+)'\s*,\s*'([^']+)'\s*\)")
    avail_re = re.compile(r"available\s*\(\s*([a-zA-Z0-9_]+)\s*,\s*\[([^\]]*)\]\s*\)")

    with open(file_path, 'r') as f:
        for line in f:
            line = line.strip()
            # Safely skip empty lines and explicit Prolog comments
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
                # Split and convert the comma-separated string of IDs into integers
                ids = [int(x.strip()) for x in id_str.split(',')] if id_str else []
                availabilities[name] = ids

    return shifts, availabilities


# =============================================================================
# 2. SOLVER PORTION (Independent Student Work)
# =============================================================================
def solve_schedule(shifts, availabilities):
    """
    Finds the unique valid schedule assignment using a backtracking search
    optimized with the Most Constrained Variable (MRV) heuristic.
    """
    N = len(shifts)
    M = len(availabilities)
    if M == 0:
        return None
        
    # Calculate target shifts per volunteer: K = N / M
    K = N // M  
    
    # Invert the availability mapping: Shift ID -> List of eligible Volunteers
    shift_to_volunteers = {s_id: [] for s_id in shifts}
    for vol, s_list in availabilities.items():
        for s_id in s_list:
            if s_id in shift_to_volunteers:
                shift_to_volunteers[s_id].append(vol)
                
    # MRV Heuristic: Sort shifts so we assign the most heavily restricted ones first
    sorted_shift_ids = sorted(shifts.keys(), key=lambda s: len(shift_to_volunteers[s]))
    
    assignment = {}
    vol_counts = {vol: 0 for vol in availabilities}
    
    def backtrack(index):
        # Base Case: All shifts successfully allocated
        if index == len(sorted_shift_ids):
            return True
            
        s_id = sorted_shift_ids[index]
        
        # Try assigning each eligible volunteer to this shift
        for vol in shift_to_volunteers[s_id]:
            # Constraint Check: Ensure volunteer hasn't reached their maximum quota (K)
            if vol_counts[vol] < K:
                # Place tentative assignment
                assignment[s_id] = vol
                vol_counts[vol] += 1
                
                # Recursively attempt to solve the remaining shifts
                if backtrack(index + 1):
                    return True
                    
                # Backtrack: Undo the assignment if it leads to a dead end
                vol_counts[vol] -= 1
                del assignment[s_id]
                
        return False

    if backtrack(0):
        return assignment
    return None


def main():
    if len(sys.argv) < 2:
        print("Usage: python3 volunteer_solver.py <path_to_puzzle.pl>")
        sys.exit(1)
        
    file_path = sys.argv[1]
    shifts, availabilities = parse_puzzle(file_path)
    solution = solve_schedule(shifts, availabilities)
    
    if solution:
        # Output results explicitly sorted by Shift ID
        for s_id in sorted(shifts.keys()):
            stall, time = shifts[s_id]
            vol = solution[s_id]
            print(f"Shift {s_id} ({stall} @ {time}): {vol}")
    else:
        print("No valid assignment satisfies all constraints.")


if __name__ == "__main__":
    main()