import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  JoinColumn,
} from 'typeorm';
import { Question } from './question.entity';
import { ApiProperty } from '@nestjs/swagger';

@Entity('answers')
export class Answer {
  @ApiProperty({
    description: 'Identificador único de la respuesta',
    example: 'd1e9f16b-23b4-4c7f-9187-8fc8f76d8f6c',
    uniqueItems: true,
  })
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @ApiProperty({
    description: 'Texto de la respuesta',
    example: 'París',
  })
  @Column('text')
  enunciado: string;

  @ApiProperty({
    description: 'Indica si la respuesta es correcta o no',
    example: true,
  })
  @Column('bool')
  correcta: boolean;

  @ApiProperty({
    description: 'Pregunta a la que pertenece la respuesta',
    type: () => Question,
  })
  @ManyToOne(() => Question, (question) => question.answers, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'question_id' })
  question: Question;
}
