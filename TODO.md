* Driving OR iterated

* Runner? Executor?
  - hooks up source to flow,
  - if iterated source, drives it, otherwise sits in the flow

* these set the contract for the inbound products

### slots

Typical case: one input, `:input`, one output `:output`

* there are as many products as
  - the total number of action stage outputs
  - the concrete input products
* The number of rsrc->action edges is at most the total number of input slots
  - (you cannot wire multiple products to the same input slot)


1. action stage B wires up to an action stage A (which really means "the full set of A's outputs")
2. I wire action A's output as production product X
3. 

4. How do I address other stages?
   - `mapper.cat` a great name for action stage `cat` inside chain `mapper`
   - `mapper.cat:output`? `mapper.cat_output`?

Subgraphs own their contents


## Configuration

* options on processor become options on flow -- so, in the telegram example, 
  :break_length becomes configurable (somehow)
  
## Tests

* add an examples helper -- runs script on file from data dir, diffs the output.



__________________________________________________________________________



* [Ruby-Graphviz](https://github.com/glejeune/Ruby-Graphviz.git) Ruby interface to the GraphViz graphing tool
* [Ruby GraphML Parser](https://github.com/willcannings/ruby-graphml.git)



* everything accessible from clean (non-magical) methods.

* inputs and outputs:
  - inputs and outputs become an array of symbols


* You can only have as many macro edges as inputs

* action stage 'ports'
  - a list of names for them
  - can also have an edge going to a 


        _____
        |
        --v--
          |
          |
        __^____^__
        | x  | y |
        |  foo   |
        ----------

create a product with no action? action with anonymous product, wired up later?


* connections:

  - action -> action:
  
        act_a -> actb
        
        


    act_a :o1 -> rsrc_x
    act_a :o2 -> rsrc_y
    
    act_b :i  <- act_a
    
    
    
* references:
  - 





