//
//  SpellCorrector.cpp
//  SoundBoard
//
//  Created by Gregory Klein on 3/14/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#include "SpellCorrector.h"

#include <fstream>
#include <string>
#include <algorithm>
#include <iostream>

#include "SpellCorrector.h"

using namespace std;

bool sortBySecond(const pair<std::string, int>& left, const pair<std::string, int>& right)
{
   return left.second < right.second;
}

char filterNonAlphabetic(char& letter)
{
   if (isalpha(letter))
      return tolower(letter);
   return '-';
}

void SpellCorrector::load(const std::string& filename)
{
   ifstream file(filename.c_str(), ios_base::binary | ios_base::in);

   file.seekg(0, ios_base::end);
   long long int length = file.tellg();
   file.seekg(0, ios_base::beg);

   string line(length, '0');

   file.read(&line[0], length);

   transform(line.begin(), line.end(), line.begin(), filterNonAlphabetic);

   string::size_type begin = 0;
   string::size_type end   = line.size();

   for (string::size_type i = 0;;)
   {
      while (line[++i] == '-' && i < end); //find first '-' character

      if (i >= end)
      {
         break;
      }

      begin = i;
      while (line[++i] != '-' && i < end); //find first not of '-' character

      dictionary[line.substr(begin, i - begin)]++;
   }
}

Dictionary SpellCorrector::correct(const std::string& word)
{
   Vector result;
   Dictionary candidates;

   if (dictionary.find(word) != dictionary.end())
   {
      result.push_back(word);
      return candidates;
   }

   edits(word, result);
   known(result, candidates);

   if (candidates.size() > 0)
   {
      return candidates;
   }

   for (unsigned int i = 0;i < result.size();i++)
   {
      Vector subResult;

      edits(result[i], subResult);
      known(subResult, candidates);
   }

   if (candidates.size() > 0)
   {
      return candidates;
   }

   candidates.clear();
   return candidates;
}

void SpellCorrector::known(Vector& results, Dictionary& candidates)
{
   Dictionary::iterator end = dictionary.end();

   for (unsigned int i = 0;i < results.size();i++)
   {
      Dictionary::iterator value = dictionary.find(results[i]);

      if (value != end)
      {
         candidates[value->first] = value->second;
      }
   }
}

void SpellCorrector::edits(const std::string& word, Vector& result)
{
   for (string::size_type i = 0;i < word.size(); i++)
   {
      result.push_back(word.substr(0, i) + word.substr(i + 1)); // deletions
   }
   for (string::size_type i = 0;i < word.size() - 1;i++)
   {
      result.push_back(word.substr(0, i) + word[i+1] + word.substr(i + 2)); // transposition
   }

   for (char j = 'a';j <= 'z';++j)
   {
      for (string::size_type i = 0;i < word.size(); i++)
      {
         result.push_back(word.substr(0, i) + j + word.substr(i + 1)); // alterations
      }
      for (string::size_type i = 0;i < word.size() + 1;i++)
      {
         result.push_back(word.substr(0, i) + j + word.substr(i)); // insertion
      }
   }
}
