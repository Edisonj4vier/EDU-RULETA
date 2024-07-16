import { Module } from '@nestjs/common';
import { SubjectService } from './subject.service';
import { SubjectController } from './subject.controller';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Subject } from './entities/subject.entity';

@Module({
  controllers: [SubjectController],
  providers: [SubjectService],
  imports: [ConfigModule, TypeOrmModule.forFeature([Subject])],
  exports: [TypeOrmModule],
})
export class SubjectModule {}
