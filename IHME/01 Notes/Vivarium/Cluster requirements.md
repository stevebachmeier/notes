Goal: How should I launch these jobs?
- How many threads?
- How much mem do we need?

The rule of thumb is to never request more than 50% of a queue's resoures.
- All.q
	- Memory: ~137 TB
	- Threads: ~16,440
- Long.q
	- Memory: ~69.1 TB
	- Threads: ~6,968

# Example
- Job mem = 16G (3 GB is the default)
- Job threads = 1 (default)
- Job runtime = 24 hours (default)
- Seeds = 200
- Draws = 66
- Scenarios = 5
- Njobs = 200\*66\*5 = 66,000 

Total number of sims (jobs) = 200* 66 * 5 = 66,000 (3GB, 1 thread, 24 hours)

## Srun
Srun (where I launch `psimulate` from) request:
- Use proj_simscience_prod
- Mem: not real sure. If you get OOMed you'll need to `psimulate restart`
- Threads: 2 + 1 per 1000 sims = 2 + 1 * (66000/1000) = 68 
- Note: 
    - If I didn't request enough threads, it would run but slowly b/c of excess ctx switching
    - If I requested too much, they go unused

# Cluster requirements. 
We don't want to upset folks AND we need to ake sure we're not requesting more than ~50% of what the queue has.
- Threads: 1 thread for each worker (eg 66000 threads)
- Mem: 16 GB * 66000 threads = ~1 PB

This is far larger than any of our cluster queues. 
	
Solution: Run incrementally, eg 10 draws at a time and leverage `psimulate expand` 

#cluster #vivarium 