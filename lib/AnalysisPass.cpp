#include "Pass.h"
#include "llvm/ADT/SmallPtrSet.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/CFG.h"

using namespace llvm;

namespace pass {
    // Initialize the analysis key.
    AnalysisKey AnalysisPass::Key;

    AnalysisPass::Result AnalysisPass::run(Function &F, FunctionAnalysisManager &FAM) {
        return {};
    }

    void printDominators(
        DenseMap<BasicBlock*,
        SmallPtrSet<BasicBlock*, 8>>& domMap) 
    {
        errs() << "Printing Dominators\n";
        std::for_each(domMap.begin(), domMap.end(), [](auto& p) {
            errs() << p.first->getName() << ": ";
            std::for_each(p.second.begin(), p.second.end(), [](auto* v) {
                errs() << v->getName() << ", ";
            });
            errs() << "\n";
        });
        errs() << '\n';
    }

    void printImmediateDominators(DenseMap<BasicBlock*, BasicBlock*>& immDomMap) {
        errs() << "Printing Immediate Dominators\n";
        std::for_each(immDomMap.begin(), immDomMap.end(), [](auto& p) {
            errs() << p.first->getName() << ": " << p.second->getName() << '\n';
        });
        errs() << '\n';
    }

    void printDominatorTree(DenseMap<BasicBlock*, SmallVector<BasicBlock*>>& tree) {
        errs() << "Printing Dominator Tree\n";
        std::for_each(tree.begin(), tree.end(), [](auto& p) {
            errs() << p.first->getName() << ": ";
            std::for_each(p.second.begin(), p.second.end(), [](auto* v) {
                errs() << v->getName() << ", ";
            });
            errs() << "\n";
        });
        errs() << '\n';
    }

    void prettyPrintTree(DenseMap<BasicBlock*, SmallVector<BasicBlock*>>& tree, BasicBlock* entryBlock, int level) {
        errs() << std::string(level, ' ') << "[" << level + 1 << "] " << entryBlock->getName() << '\n';
        level++; 
        std::for_each(tree[entryBlock].begin(), tree[entryBlock].end(), [&tree, level](auto* block) {
            prettyPrintTree(tree, block, level);
        });
    }

    void prettyPrintTree_w(DenseMap<BasicBlock*, SmallVector<BasicBlock*>>& tree, BasicBlock* entryBlock) {
        errs() << "Pretty Printing Dominator Tree\n";
        prettyPrintTree(tree, entryBlock, 0);
        errs() << '\n';
    }

    void printHeaders(DenseMap<BasicBlock*, SmallVector<BasicBlock*>>& headers) {
        errs() << "Printing headers\n";
        std::for_each(headers.begin(), headers.end(), [](auto& p) {
            errs() << "<header>" << p.first->getName() << " ";
            std::for_each(p.second.begin(), p.second.end(), [](auto* v) {
                errs() << "<latch>" << v->getName() << ",";
            });
            errs() << '\n';
        });
        errs() << '\n';
    }

    void printBody(SmallPtrSet<BasicBlock*, 4>& body) {
        errs() << "Printing Loop body\n";
        std::for_each(body.begin(), body.end(), [] (auto* elem) {
            errs() << elem->getName() << ',';
        });
        errs() << '\n';
    }

    bool equalPtrSet(
        SmallPtrSet<BasicBlock*, 8> set1,
        SmallPtrSet<BasicBlock*, 8> set2) 
    {
        if (set1.size() != set2.size()) { return false; }
        return std::equal(set1.begin(), set1.end(), set2.begin(), set2.end());
    }

    void getIntersection(
        BasicBlock* currentBlock,
        SmallPtrSet<BasicBlock*, 8>& initialSet,
        DenseMap<BasicBlock*, SmallPtrSet<BasicBlock*, 8>>& domMap)
    {
        BasicBlock* first = *pred_begin(currentBlock);
        initialSet = domMap[first];

        SmallPtrSet<BasicBlock*, 8> res;
        for (BasicBlock* predecessor : predecessors(currentBlock)) {
            for (BasicBlock* elem : initialSet) {
                if (domMap[predecessor].count(elem)) {
                    res.insert(elem);
                }
            }
            initialSet = res;
            res.clear();
        }        
    }

    void getDominators(
        BasicBlock* entryBlock,
        SmallPtrSet<BasicBlock*, 8>& allBlocks,
        DenseMap<BasicBlock*, SmallPtrSet<BasicBlock*, 8>>& domMap) 
    {
        bool flag = false;
        do {
            flag = false;
            for (BasicBlock* block : allBlocks) {
                if (block == entryBlock) { continue; }
                
                SmallPtrSet<BasicBlock*, 8> initialSet;
                if (pred_begin(block) != pred_end(block)) {
                    getIntersection(block, initialSet, domMap);
                }
                
                // union 
                initialSet.insert(block);
                // checks if any changed took place in dominators from previous iteration
                flag = !equalPtrSet(domMap[block], initialSet) ? true : flag;

                domMap[block] = initialSet;
            }
        } while(flag);
    }

    void getImmediateDominators(
        BasicBlock* entryBlock,
        SmallPtrSet<BasicBlock*, 8>& allBlocks,
        DenseMap<BasicBlock*, BasicBlock*>& immDomMap,
        DenseMap<BasicBlock*, SmallPtrSet<BasicBlock*, 8>>& domMap)
    {
        for (BasicBlock* waste : allBlocks) {
            if (waste == entryBlock) { continue; }
            auto copyOfDominators = domMap[waste];
            for (BasicBlock* b1 : domMap[waste]) {
                for (BasicBlock* b2 : domMap[waste]) {
                    if (b1 == b2) { continue; }
                    if (std::find(domMap[b2].begin(), domMap[b2].end(), b1) != domMap[b2].end()) {
                        copyOfDominators.erase(b1);
                        break;
                    }
                }
            }

            immDomMap[waste] = *(copyOfDominators.begin());
        }
    }

    bool isHeader(BasicBlock* n, BasicBlock* h) {
        return std::find(successors(n).begin(), successors(n).end(), h) != successors(n).end();
    }

    void locateHeaders(
        SmallPtrSet<BasicBlock*, 8>& allBlocks,
        DenseMap<BasicBlock*, SmallPtrSet<BasicBlock*, 8>>& domMap,
        DenseMap<BasicBlock*, SmallVector<BasicBlock*>>& headers)
    {
        for (BasicBlock* n : allBlocks) {
            for (BasicBlock* h : domMap[n]) {
                if (isHeader(n, h)) {
                    headers[h].push_back(n);
                } 
            }
        }
    }

    void getLoopBody(
    BasicBlock* header,
    SmallVector<BasicBlock*>& latches,
    SmallPtrSet<BasicBlock*, 4>& body) 
    {
        for (auto* latch : latches) {
            SmallVector<BasicBlock*> stack;
            stack.push_back(latch);

            while (stack.size()) {
                auto* D = stack[stack.size() - 1];
                stack.pop_back();

                if (std::find(body.begin(), body.end(), D) == body.end()) {
                    body.insert(D);
                    
                    for (auto* pred : predecessors(D)) {
                        stack.push_back(pred);
                    }
                }
            }
        }
    }

    PreservedAnalyses PrintAnalysisPass::run(Function &F, FunctionAnalysisManager &FAM) {
        DenseMap<BasicBlock*, SmallPtrSet<BasicBlock*, 8>> domMap;
        
        // entry block has only itself as its dominator
        BasicBlock& entryBlock = F.front();
        domMap[&entryBlock] = {&entryBlock};

        // get the list of blocks
        SmallPtrSet<BasicBlock*, 8> allBlocks;
        std::for_each(F.begin(), F.end(), [&allBlocks](BasicBlock& bb) { allBlocks.insert(&bb); });
        
        // initialize all other blocks except entry block to have every other block as dominator
        for (BasicBlock& bb : F) {
            if (&bb == &entryBlock) { continue; }
            domMap[&bb] = allBlocks;
        }
        
        getDominators(&entryBlock, allBlocks, domMap);

        printDominators(domMap);

        // remove the block from its own dominator list
        std::for_each(domMap.begin(), domMap.end(), [](auto& p) { p.second.erase(p.first); });

        DenseMap<BasicBlock*, BasicBlock*> immDomMap;
        getImmediateDominators(&entryBlock, allBlocks, immDomMap, domMap);

        // printImmediateDominators(immDomMap);

        DenseMap<BasicBlock*, SmallVector<BasicBlock*>> tree;
        std::for_each(allBlocks.begin(), allBlocks.end(), [&tree](auto* v) { tree[v] = {}; });
        std::for_each(immDomMap.begin(), immDomMap.end(), [&tree](auto &p) { tree[p.second].push_back(p.first); });

        printDominatorTree(tree);
        prettyPrintTree_w(tree, &entryBlock);

        std::for_each(domMap.begin(), domMap.end(), [](auto& p) { p.second.insert(p.first); });
        DenseMap<BasicBlock*, SmallVector<BasicBlock*>> headers;
        locateHeaders(allBlocks, domMap, headers);

        printHeaders(headers);

        for (auto& p : headers) {
            SmallPtrSet<BasicBlock*, 4> body = {p.first};
            getLoopBody(p.first, p.second, body);
            printBody(body);
        }

        return PreservedAnalyses::all();
    }
}