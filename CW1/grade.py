#!/usr/bin/env python3
"""
Grading script for Code1.pl, likes.pl, and family_cw.pl.

Total: 16 points (Code1.pl = 10, likes.pl = 3, family_cw.pl = 3).

Each test is executed in its own `swipl` process and is wrapped in a Prolog
catch/3, so an undefined predicate, a runtime error, or a hang in one test
cannot affect any other test.  A missing or unloadable file only zeros out
that file's tests; the other files still run.

Usage:
    python3 grade.py [directory_containing_pl_files]

Requires:
    swipl on PATH.
"""

import os
import subprocess
import sys
from collections import OrderedDict


# ---------------------------------------------------------------------------
# Test table:  (file, description, guard, prolog_goal, points)
# ---------------------------------------------------------------------------
TESTS = [
    # ----------------------- Code1.pl  (10 points) -----------------------
    ('Code1.pl', 'strictlyIncreasing/3', 'strictlyIncreasing/3',
        r'strictlyIncreasing(1,2,3), \+ strictlyIncreasing(2,2,3)', 1),
    ('Code1.pl', 'nonDecreasing/3', 'nonDecreasing/3',
        r'nonDecreasing(1,2,2), \+ nonDecreasing(3,2,1)', 1),
    ('Code1.pl', 'quotient_remainder/4', 'quotient_remainder/4',
        'quotient_remainder(17,5,3,2)', 1),
    ('Code1.pl', 'factorial/2', 'factorial/2',
        'factorial(5,120)', 1),
    ('Code1.pl', 'pow/3', 'pow/3',
        'pow(2,10,1024)', 1),
    ('Code1.pl', 'blocks (on, above, left)', 'on/2',
        'on(b5,b6), above(b1,b2), left(b3,b7)', 1),
    ('Code1.pl', 'len/2 and sum/2', 'len/2',
        'len([1,2,3,4],4), sum([10,20,30],60)', 1),
    ('Code1.pl', 'is_sorted/1 and rev/2', 'is_sorted/1',
        r'is_sorted([1,2,2,3]), \+ is_sorted([1,3,2]), rev([1,2,3],[3,2,1])', 1),
    ('Code1.pl', 'merge/3', 'merge/3',
        'merge([1,3,5],[2,4,6],[1,2,3,4,5,6])', 1),
    ('Code1.pl', 'merge_sort/2', 'merge_sort/2',
        'merge_sort([3,1,4,1,5,9,2,6],[1,1,2,3,4,5,6,9])', 1),

    # ----------------------- likes.pl  (3 points) ------------------------
    ('likes.pl', 'paul likes what john likes', 'likes/2',
        'likes(paul,sushi), likes(paul,pizza)', 1),
    ('likes.pl', 'calzone & cilantro rules', 'likes/2',
        r'likes(john,calzone), likes(john,cilantro), \+ likes(mary,cilantro)', 1),
    ('likes.pl', 'dislikes/2', 'dislikes/2',
        r'dislikes(bob,pizza), \+ dislikes(john,icecream)', 1),

    # --------------------- family_cw.pl  (3 points) ----------------------
    ('family_cw.pl', 'sibling/2', 'sibling/2',
        r'sibling(john,jane), \+ sibling(john,john)', 1),
    ('family_cw.pl', 'gendered/1', 'gendered/1',
        r'gendered(john), gendered(sue), \+ gendered(gina)', 1),
    ('family_cw.pl', 'all_gendered/0 + gender_but_not_person/1', 'all_gendered/0',
        r'\+ all_gendered, gender_but_not_person(june)', 1),
]


def _prolog_quote_path(path: str) -> str:
    """Quote a filesystem path so it can be used as a single-quoted Prolog atom."""
    return path.replace('\\', '\\\\').replace("'", "\\'")


def run_test(filepath: str, guard: str, goal: str, timeout: int = 20):
    if not os.path.isfile(filepath):
        return 'MISSING', f'file not found: {filepath}'

    abs_path = os.path.abspath(filepath)
    qfp = _prolog_quote_path(abs_path)

    if guard and guard != 'none':
        try:
            name, arity_str = guard.split('/')
            arity = int(arity_str)
        except ValueError:
            return 'UNKNOWN', f'bad guard spec: {guard!r}'
        if arity == 0:
            head_term = name
        else:
            head_term = f"{name}(" + ','.join(['_'] * arity) + ")"
            
        # WINDOWS PATH FIX: Use absolute_file_name/2 so Prolog resolves the OS-specific casing and slashes natively.
        ownership_check = (
            f"( absolute_file_name('{qfp}', CanonicalFile), "
            f"  current_predicate({guard}), "
            f"  predicate_property({head_term}, file(CanonicalFile)) "
            f"-> true "
            f"; write(not_owned), nl, halt )"
        )
    else:
        ownership_check = "true"

    inner = f"(({goal}) -> write(pass) ; write(fail))"
    prolog = (
        f"catch(consult('{qfp}'), _Ec, "
        f"  (write('consult_error '), write(_Ec), nl)), "
        f"{ownership_check}, "
        f"catch({inner}, _Et, "
        f"  (write('error '), write(_Et))), "
        f"nl, halt."
    )

    cmd = ['swipl', '-q', '-g', prolog, '-t', 'halt(1)']

    try:
        r = subprocess.run(cmd, capture_output=True, text=True, timeout=timeout)
    except subprocess.TimeoutExpired:
        return 'TIMEOUT', f'>{timeout}s'
    except FileNotFoundError:
        return 'NO_SWIPL', 'swipl not on PATH'

    stdout = (r.stdout or '').strip()
    stderr = (r.stderr or '').strip()

    lines = [ln.strip() for ln in stdout.splitlines() if ln.strip()]
    result_line = lines[-1] if lines else ''
    preamble = ' | '.join(lines[:-1]) if len(lines) > 1 else ''

    if result_line == 'pass':
        return 'PASS', ''
    if result_line == 'fail':
        return 'FAIL', preamble
    if result_line == 'not_owned':
        return 'NOT_OWNED', f'{guard} not defined in student file'
    if result_line.startswith('error'):
        msg = result_line[len('error'):].strip()
        if preamble:
            msg = f'{preamble} | {msg}'
        return 'ERROR', msg
    detail = f'stdout={stdout!r}'
    if stderr:
        detail += f' stderr={stderr!r}'
    return 'UNKNOWN', detail


def main():
    base = sys.argv[1] if len(sys.argv) > 1 else '.'
    base = os.path.abspath(base)
    print(f'Grading from: {base}')
    print('=' * 78)

    grouped = OrderedDict()
    for fname, desc, guard, goal, pts in TESTS:
        grouped.setdefault(fname, []).append((desc, guard, goal, pts))

    overall_earned = 0
    overall_max = 0
    file_totals = OrderedDict()

    for fname, items in grouped.items():
        path = os.path.join(base, fname)
        print(f'\n--- {fname} ---')
        f_earned = 0
        f_max = 0
        for desc, guard, goal, pts in items:
            status, detail = run_test(path, guard, goal)
            earned = pts if status == 'PASS' else 0
            f_earned += earned
            f_max += pts
            mark = '+' if status == 'PASS' else '-'
            line = f'  [{mark}] {desc:<48} {status:<8} {earned}/{pts}'
            if detail and status != 'PASS':
                d = detail.replace('\n', ' ')
                if len(d) > 80:
                    d = d[:77] + '...'
                line += f'   {d}'
            print(line)
        print(f'  ----- {fname} subtotal: {f_earned}/{f_max} -----')
        file_totals[fname] = (f_earned, f_max)
        overall_earned += f_earned
        overall_max += f_max

    print('\n' + '=' * 78)
    print('Summary:')
    for fname, (e, p) in file_totals.items():
        print(f'  {fname:<22} {e}/{p}')
    print('-' * 78)
    print(f'TOTAL: {overall_earned} / {overall_max}')

    sys.exit(0)


if __name__ == '__main__':
    main()