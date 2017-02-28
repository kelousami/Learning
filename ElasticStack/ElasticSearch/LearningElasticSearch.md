# Elastic Stack

## Elastic Search 

Elasticsearch is a highly scalable open source full-text search and analytics
engine. It allows storing, searching and analyzing big volumes of data quickly.

ELK (Elasticsearch/Logstash/Kibana) is a famous use case applied to logs
and/or transaction data.

### Basic concepts 

#### NRT
Near Real Time means that there is a slight latency between the moment we index
a document until it becomes searchable. (we talk about a second or so)

#### Cluster
Default name of the cluster is `elasticsearch`. We have to change it to avoid
confusion into something like `logging-stage` or `logging-prod`. The name is
actually used by nodes to identify to which cluster they belong.

#### Node
Stores data. When it is part of a cluster its name is by default generated at
startup and takes the form of _Universally Unique IDentifier (UUID)_. We need
also to change it to meaningfull name that match the server on whitch it runs
whitch help its administation.

When a node is run in signle mode (outside any cluster) it has default name of
`elasticsearch`.

#### Index
Is a collection of documents.
In a single cluster we can have as many indexes as we would like.
Name of index __must__ be __lowercase__.
Index name is its reference when we want to perform operations against
documents in that index, including: indexing, searching, updating and deleting.

#### Type
Logical category/partition of documents inside an index.
Semantics of types is left to user.
We may have one or multiple types in a single index.
For example, in a blog platform we may have three types:
- User data type
- Blog data type
- Comments data type

#### Document
Is the basic unit of information that can be indexed.
Expressed in _JavaScrit Object Notation (JSON)_.
Within an index, we may have as many documents as needed.
__Must__ be __indexed/assigned__ to a __type__.


#### Shards & Replicas
As index may be of any size, shards is a way to split indexes into independent
subindexes.
Replicas are copies of particulare index (set of shards).
Once replicated, an index have primary shards (original) and replicas.
By default, each index in Elasticsearch is allocated 5 shards ans 1 replica.
Which means in case of 2 nodes, that each node will have 5 shards (10 in total,
5 primary and 5 copies)
Each Elasticsearch shard is a Lucene index.

### Installing Elasticsearch

#### Important consideration
The install process is very well described in _Elastic.io_ site:
[link]https://goo.gl/ib5piQ

What need to be taken into consideration is the difference between
_development_ environment and production (like) one.

Elasticsearch consider that we are runing on development mode as long as we
keep using the _loopback_ addresses only - e.g. 127.0.0.1

Once we change the value of `network.host` in `elasticsearch.yml` configuration
file to a custom value, then we tell Elasticsearch that we are no more in a
development mode.

This very important because it triggers enforced _boorstrap checks_. While those
checks, when failed in development mode, only inform user by logging _WARN_ messages, 
they actually _turn the server down_ when failing in non-development modes.

The list and description of those checks, including heap size check, memory
checks, jvm checks ond other checks are decribed here:
[link]https://goo.gl/7uzUSy


